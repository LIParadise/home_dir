#!/bin/sh

fn_if_in_default_route(){
        ip route | grep default | grep -ic "${1}"
}
fn_get_default_route_settings(){
        ip route | grep default | grep "${1}" | head -n 1
}
fn_my_inspect(){
        echo ""
        for arg in "$@"
        do
                printf "\n\$$arg is ... "
                eval printf "%s" "\${${arg}}"
                printf "  PEKORA"
        done
        echo ""
}

ppp_in_default_route=$(fn_if_in_default_route ppp)
vpn_in_default_route=$(fn_if_in_default_route vpn)
dhcp_in_default_route=$(fn_if_in_default_route dhcp)
vpn_default_route_settings=$(fn_get_default_route_settings vpn)
dhcp_default_route_settings=$(fn_get_default_route_settings dhcp)
default_route_count=$(ip route | grep -c default)

vpn_route_metric=$(ip route | grep default | grep vpn | head -n 1 | awk -F" " '{print $NF}')
dhcp_route_metric=$(ip route | grep default | grep dhcp | head -n 1 | awk -F" " '{print $NF}')
ppp_route_metric=60

vpn_route_name="$(ip route | grep default | grep vpn | head -n 1 | cut -d' ' -f 3)"
dhcp_route_name="$(ip route | grep default | grep dhcp | head -n 1 | cut -d' ' -f 3)"
ppp_route_name="$(ip route | grep default | grep ppp | head -n 1 | cut -d' ' -f 3)"

while [ "$default_route_count" -gt 0 ]
do
        ip route del default
        default_route_count=$((default_route_count-1))
done

if [ "$vpn_in_default_route" -gt 0 ]; then
        echo "ip route add \"$vpn_default_route_settings\""
        ip route add ${vpn_default_route_settings}
        ppp_route_metric=$((vpn_route_metric+10))
else
        echo "no default vpn routes"
fi

if [ "$dhcp_in_default_route" -gt 0 ]; then
        echo "ip route add \"$dhcp\""
        ip route add ${dhcp_default_route_settings}
        if [ "$dhcp_route_metric" -lt "$ppp_route_metric" ]; then
                ppp_route_metric=$((dhcp_route_metric-1))
        fi
else
        echo "no default dhcp routes"
fi

if [ "$ppp_in_default_route" -gt 0 ]; then
        echo "ip route add default \"$ppp_route_name\" metric \"$ppp_route_metric\""
        ip route add default dev "$ppp_route_name" metric "$ppp_route_metric"
else
        echo "no default ppp routes"
fi

if [ "$(ip route | grep -c default)" -eq 0 ]; then
        echo "no default routes detected"
        echo "ip route add dev ppp0 default"
        ip route add dev ppp0 default metric "${ppp_route_metric}"
else
        echo "there shall be default routes...?"
        echo ""
fi

fn_my_inspect ppp_in_default_route vpn_in_default_route dhcp_in_default_route
echo "Overall...."
echo ""
ip route
