# 1. Create docker network, so db and keycloak can connect with each other: docker network create keycloak-network
# 2. Connect db container to network: docker network connect keycloak-network <db-container-id>
# 3. Create DB and user for keycloak: 
#     - docker exec -it <db-container-name> psql -h localhost -U <table_name> -c "create user keycloak with encrypted password 'secret';"
#     - docker exec -it <db-container-name> psql -h localhost -U <table_name> -c "CREATE DATABASE keycloak OWNER keycloak;"
# 4. Add network param to keycloak container: ... --net keycloak-network ...

# build: docker build . -t keycloak(_dev)
# run dev : docker run --name keycloak_dev -p 8080:8080 --net keycloak-network -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -e KC_DB_URL=jdbc:postgresql://<db_url>:<db_port>/keycloak -ec KC_DB_USERNAME=keycloak -e KC_DB_PASSWORD=secret -e KC_HOSTNAME=localhost -e KC_DB_USERNAME=keycloak -e start_command=start-dev keycloak_dev
# run prod: docker run --name keycloak -p 8443:8443 --net keycloak-network -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -e KC_DB_URL=jdbc:postgresql://<db_url>:<db_port>/keycloak -e KC_DB_USERNAME=keycloak -e KC_DB_PASSWORD=secret -e KC_HOSTNAME=localhost -e KC_DB_USERNAME=keycloak -e start_command=start keycloak

ARG keycloak_version=latest
ARG keycloak_image_url=quay.io/keycloak/keycloak:${keycloak_version}

FROM node:latest as keycloak_asset_builder

RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm

WORKDIR /keycloak_assets
COPY . /keycloak_assets

RUN pnpm install
RUN pnpm build

####

ARG keycloak_version
ARG keycloak_image_url

FROM ${keycloak_image_url} as keycloak_builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
#ENV KC_FEATURES=token-exchange

ENV KC_DB=postgres

# Install custom providers
# https://github.com/aerogear/keycloak-metrics-spi/
RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar

# copy asset build from above
COPY --from=keycloak_asset_builder /keycloak_assets/themes /opt/keycloak/themes/

# import all preconfigured realms
# https://github.com/keycloak/keycloak-quickstarts/blob/latest/quickstart-realm.json
# COPY realm_config/ /opt/keycloak/data/import

RUN /opt/keycloak/bin/kc.sh build

#####

FROM ${keycloak_image_url} as keycloak_runtime
COPY --from=keycloak_builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak
# for demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

ENV start_command="start"

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["${start_command} --import-realm"]
