#!/bin/sh

set -euxv

KCADM=/opt/keycloak/bin/kcadm.sh

${KCADM} config credentials --server "$KC_INTERNAL_HOSTNAME_URL" --realm master --user "$KEYCLOAK_ADMIN" --password "$KEYCLOAK_ADMIN_PASSWORD"

${KCADM} create realms \
    -s "realm=${OIDC_ADMIN_REALM}" \
    -s enabled=true \
    -s 'displayName="Company Employees"' \
    -s accessTokenLifespan=300 \
    -s ssoSessionIdleTimeout=3600 \
    -s ssoSessionMaxLifespan=3600 \
    -s revokeRefreshToken=true \
    -s refreshTokenMaxReuse=0 \
    -s defaultSignatureAlgorithm=RS256

${KCADM} create clients -r ${OIDC_ADMIN_REALM} -f - <<EOF
{
    "protocol": "openid-connect",
    "clientId": "${OIDC_ADMIN_APP_ID}",
    "directAccessGrantsEnabled": true,
    "webOrigins": ["*"],
    "standardFlowEnabled": false,
    "clientAuthenticatorType": "client-secret",
    "secret": "${OIDC_ADMIN_APP_SECRET}",
    "bearerOnly": false,
    "publicClient": false,
    "serviceAccountsEnabled": true,
    "authorizationServicesEnabled": true,
    "attributes": {
        "client_credentials.use_refresh_token": true
    }
}
EOF

${KCADM} create clients -r ${OIDC_ADMIN_REALM} -f - <<EOF
{
    "protocol": "openid-connect",
    "clientId": "${OIDC_ADMIN_USER_ID}",
    "directAccessGrantsEnabled": true,
    "webOrigins": ["*"],
    "bearerOnly": false,
    "standardFlowEnabled": false,
    "publicClient": true,
    "serviceAccountsEnabled": false,
    "authorizationServicesEnabled": false,
    "attributes": {
        "client_credentials.use_refresh_token": true
    }
}
EOF

### Users
${KCADM} create users -r ${OIDC_ADMIN_REALM} -s enabled=true -s emailVerified=true -s username=john.doe -s email=john.doe@wayof.dev -s firstName=John -s lastName=Doe
${KCADM} set-password -r ${OIDC_ADMIN_REALM} --username john.doe --new-password john.doe

${KCADM} create users -r ${OIDC_ADMIN_REALM} -s enabled=true -s emailVerified=true -s username=jane.doe -s email=jane.doe@wayof.dev -s firstName=Jane -s lastName=Doe
${KCADM} set-password -r ${OIDC_ADMIN_REALM} --username jane.doe --new-password jane.doe

${KCADM} create users -r ${OIDC_ADMIN_REALM} -s enabled=true -s emailVerified=true -s username=johnny.doe -s email=johnny.doe@wayof.dev -s firstName=Johnny -s lastName=Doe
${KCADM} set-password -r ${OIDC_ADMIN_REALM} --username johnny.doe --new-password johnny.doe

### Roles
${KCADM} add-roles \
    -r ${OIDC_ADMIN_REALM} \
    --uusername "service-account-${OIDC_ADMIN_APP_ID}" \
    --cclientid realm-management \
    --rolename manage-users
