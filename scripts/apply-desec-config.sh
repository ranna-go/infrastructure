DOMAIN=ranna.dev

[ "$DESEC_TOKEN" == "" ] && {
    echo "DESEC_TOKEN must be specified"
    exit 1
}

curl -v -X POST https://desec.io/api/v1/domains/${DOMAIN}/rrsets/ \
    --header "Authorization: Token ${DESEC_TOKEN}" \
    --header "Content-Type: application/json" \
    --data @desec-rrsets.json