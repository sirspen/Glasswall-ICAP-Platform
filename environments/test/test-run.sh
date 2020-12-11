thepath="$pwd"
docker run -ti --entrypoint /bin/bash -v $thepath:/opt glasswallsolutions/c-icap-client:manual-v1
/usr/local/c-icap/bin/c-icap-client -i gw-icap-dev-nor.icap-proxy.curlywurly.me:443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-nor.pdf -v
/usr/local/c-icap/bin/c-icap-client -i gw-icap-dev-ukw.icap-proxy.curlywurly.me:443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-ukw.pdf -v

