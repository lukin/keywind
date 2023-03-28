#!/bin/sh

set -euxv

KCADM=/opt/keycloak/bin/kcadm.sh

${KCADM} config credentials --server "$KC_INTERNAL_HOSTNAME_URL" --realm master --user "$KEYCLOAK_ADMIN" --password "$KEYCLOAK_ADMIN_PASSWORD"

REALM_MASTER_FILE=/tmp/setup/realms/realm-master.json
if [ -f $REALM_MASTER_FILE ]; then
    ${KCADM} update realms/master -f $REALM_MASTER_FILE
fi

REALM_ADMIN_FILE=/tmp/setup/realms/realm-${OIDC_ADMIN_REALM}.json
if [ -f "$REALM_ADMIN_FILE" ]; then
    ${KCADM} update realms/${OIDC_ADMIN_REALM} -f "$REALM_ADMIN_FILE"
fi

REALM_CLIENT_FILE=/tmp/setup/realms/realm-${OIDC_CLIENT_REALM}.json
if [ -f "$REALM_CLIENT_FILE" ]; then
    ${KCADM} update realms/${OIDC_CLIENT_REALM} -f "$REALM_CLIENT_FILE"
fi
