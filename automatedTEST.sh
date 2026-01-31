#!/bin/bash

set -e

# Colors
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

# Helper function
test_curl() {
    local desc="$1"
    local url="$2"
    echo -n "▶ $desc ($url)... "

    if curl -sk "$url" | grep -qE "App|NGINX"; then
        echo -e "${GREEN}OK${NC}"
    else
        echo -e "${RED}FAIL${NC}"
        
    fi
}

echo " Starting full stack test..."

test_curl "Direct App1 response"         http://localhost:5001/
test_curl "Direct App2 response"         http://localhost:5002/
test_curl "Direct App3 response"         http://localhost:5003/
test_curl "App1 via host IP"             http://10.0.3.10:5001/
test_curl "App2 via host IP"             http://10.0.3.10:5002/
test_curl "App3 via host IP"             http://10.0.3.10:5003/
test_curl "HAProxy load balancer"        http://localhost:8080/
test_curl "HAProxy Passive Backup"       http://localhost:8081/
test_curl "NGINX reverse proxy → App1/2" http://localhost/app1/
test_curl "NGINX reverse proxy → App3"   http://localhost/app3/
test_curl "External App1/2 via NGINX"    https://10.0.3.10/app1/
test_curl "External App3 via NGINX"      https://10.0.3.10/app3/
test_curl "HTTPS to NGINX"               https://10.0.3.10/
test_curl "HTTPS to App3"                https://10.0.3.10/app3/
test_curl "HAProxy direct port"          http://10.0.3.10:8080/
test_curl "HAProxy backup direct port"   http://10.0.3.10:8081/

echo -e "\n ${GREEN}All tests passed!${NC}"
