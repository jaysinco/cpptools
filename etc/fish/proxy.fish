set -gx http_proxy "http://127.0.0.1:7890"
set -gx https_proxy "http://127.0.0.1:7890"
set -gx ftp_proxy "http://127.0.0.1:7890"

clash >/dev/null 2>&1 &
microsoft-edge-stable >/dev/null 2>&1 &
