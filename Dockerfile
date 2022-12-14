FROM alpine as downloader

RUN apk add git npm curl
WORKDIR /download
RUN git clone https://github.com/lukin/keywind.git
RUN chmod -R 777 /download

RUN curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm

WORKDIR /download/keywind
RUN pnpm install
RUN pnpm build


FROM quay.io/keycloak/keycloak:20.0.2 as builder

WORKDIR /keycloak_assets

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange
ENV KC_DB=postgres
# Install custom providers
#RUN curl -sL https://github.com/aerogear/keycloak-metrics-spi/releases/download/2.5.3/keycloak-metrics-spi-2.5.3.jar -o /opt/keycloak/providers/keycloak-metrics-spi-2.5.3.jar
COPY --from=downloader --chown=keycloak:root  /download/keywind/theme /opt/keycloak/themes/

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:20.0.2

COPY --from=builder /opt/keycloak/ /opt/keycloak/

WORKDIR /opt/keycloak
# change these values to point to a running postgres instance
ENV KC_DB_URL=jdbc:postgresql://postgres:5432/keycloak
ENV KC_DB_USERNAME=adminuser
ENV KC_DB_PASSWORD=keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
