export thepath=`pwd`
docker run -ti --entrypoint /bin/bash -v $thepath:/opt glasswallsolutions/c-icap-client:manual-v1
#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-dev-nor.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-dev-nor.pdf -v
#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-dev-ukw.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-dev-ukw.pdf -v

#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-prd-ukw.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-prd-ukw.pdf -v
#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-prd-nor.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-prd-nor.pdf -v
