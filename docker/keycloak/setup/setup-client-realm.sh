#!/bin/sh

set -euxv

KCADM=/opt/keycloak/bin/kcadm.sh

${KCADM} config credentials --server "$KC_INTERNAL_HOSTNAME_URL" --realm master --user "$KEYCLOAK_ADMIN" --password "$KEYCLOAK_ADMIN_PASSWORD"

${KCADM} create realms \
    -s "realm=${OIDC_CLIENT_REALM}" \
    -s enabled=true \
    -s 'displayName="Company Clients"' \
    -s accessTokenLifespan=300 \
    -s ssoSessionIdleTimeout=3600 \
    -s ssoSessionMaxLifespan=3600 \
    -s revokeRefreshToken=true \
    -s refreshTokenMaxReuse=0 \
    -s defaultSignatureAlgorithm=RS256 \
    -s editUsernameAllowed=true

${KCADM} create clients -r "${OIDC_CLIENT_REALM}" -f - <<EOF
{
      "protocol": "openid-connect",
      "clientId": "${OIDC_CLIENT_APP_ID}",
      "directAccessGrantsEnabled": true,
      "webOrigins": ["*"],
      "standardFlowEnabled": false,
      "clientAuthenticatorType": "client-secret",
      "secret": "${OIDC_CLIENT_APP_SECRET}",
      "bearerOnly": false,
      "publicClient": false,
      "serviceAccountsEnabled": true,
      "authorizationServicesEnabled": true,
      "attributes": {
            "client_credentials.use_refresh_token": true
      }
}
EOF

${KCADM} create clients -r "${OIDC_CLIENT_REALM}" -f - <<EOF
{
    "protocol": "openid-connect",
    "clientId": "${OIDC_CLIENT_USER_ID}",
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
${KCADM} create users -r "${OIDC_CLIENT_REALM}" -s enabled=true -s emailVerified=true -s username=john.roe -s email=john.roe@wayof.dev -s firstName=John -s lastName=Roe
${KCADM} set-password -r "${OIDC_CLIENT_REALM}" --username john.roe --new-password john.roe

${KCADM} create users -r "${OIDC_CLIENT_REALM}" -s enabled=true -s emailVerified=true -s username=jane.roe -s email=jane.roe@wayof.dev -s firstName=Jane -s lastName=Roe
${KCADM} set-password -r "${OIDC_CLIENT_REALM}" --username jane.roe --new-password jane.roe

${KCADM} create users -r "${OIDC_CLIENT_REALM}" -s enabled=true -s emailVerified=true -s username=johnny.roe -s email=johnny.roe@wayof.dev -s firstName=Johnny -s lastName=Roe
${KCADM} set-password -r "${OIDC_CLIENT_REALM}" --username johnny.roe --new-password johnny.roe

### Roles
${KCADM} add-roles \
    -r "${OIDC_CLIENT_REALM}" \
    --uusername "service-account-${OIDC_CLIENT_APP_ID}" \
    --cclientid realm-management \
    --rolename manage-users
