#!/bin/bash

if [[ -z "${KEYSTORE_PASS}" ]]; then >&2 echo "\$KEYSTORE_PASS (keystore) is unset" ; exit 1; fi

service=metabase
DOMAIN_NAME=dwcc-reports.hasirudala.in
METABASE_DIR=/home/app/metabase

cd /etc/letsencrypt/live/${DOMAIN_NAME}

openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out keystore.p12 \
-passin pass:${KEYSTORE_PASS} -passout pass:${KEYSTORE_PASS} \
-name metabase -CAfile chain.pem -caname root

keytool -importkeystore -deststorepass ${KEYSTORE_PASS} -destkeypass ${KEYSTORE_PASS} \
-destkeystore ${METABASE_DIR}/keystore.jks \
-srckeystore /etc/letsencrypt/live/${DOMAIN_NAME}/keystore.p12 \
-srcstoretype PKCS12 \
-srcstorepass ${KEYSTORE_PASS} -alias metabase -noprompt

chown app: ${METABASE_DIR}/keystore.jks
chmod 664 ${METABASE_DIR}/keystore.jks
