if [[ ! -e "$WEB_DOCUMENT_ROOT" ]]; then
    echo ""
    echo "[WARNING] WEB_DOCUMENT_ROOT does not exists with path \"$WEB_DOCUMENT_ROOT\"!"
    echo ""
fi

# Replace markers
find /opt/docker/etc/httpd/ -iname '*.conf' -print0 | xargs -0 -r go-replace -s "<DOCUMENT_INDEX>" -r "$WEB_DOCUMENT_INDEX"
find /opt/docker/etc/httpd/ -iname '*.conf' -print0 | xargs -0 -r go-replace -s "<DOCUMENT_ROOT>"  -r "$WEB_DOCUMENT_ROOT"
find /opt/docker/etc/httpd/ -iname '*.conf' -print0 | xargs -0 -r go-replace -s "<ALIAS_DOMAIN>"   -r "$WEB_ALIAS_DOMAIN"
find /opt/docker/etc/httpd/ -iname '*.conf' -print0 | xargs -0 -r go-replace -s "<SERVERNAME>"     -r "$HOSTNAME"

if [[ -n "${WEB_PHP_SOCKET+x}" ]]; then
    ## WEB_PHP_SOCKET is set
    find /opt/docker/etc/httpd/ -iname '*.conf' -print0 | xargs -0 -r go-replace -s "<PHP_SOCKET>" -r "$WEB_PHP_SOCKET"
else
    ## WEB_PHP_SOCKET is not set, remove PHP files
    rm -f -- /opt/docker/etc/httpd/conf.d/10-php.conf
fi