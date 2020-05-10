ip a | grep -E ': enp0s19f2u3:.*state UP' || ip link set dev enp0s19f2u3 up
dhcpcd -4 -y 60 -m 4 -l 60  -j /var/log/dhcpcd/enp0s19f2u3.txt enp0s19f2u3

while (ip a | grep -E ': enp0s19f2u3:.*state UP'); do
    dhcpcd  -inform6 -6 -y 60 -m 4 -l 60 -k -j /var/log/dhcpcd/enp0s19f2u3_ipv6.txt enp0s19f2u3
    sleep 15
    dhcpcd  -inform6 -6 -y 60 -m 4 -l 60    -j /var/log/dhcpcd/enp0s19f2u3_ipv6.txt enp0s19f2u3
    if [ $? -eq 0 ]; then
        echo "Ipv 6 is Good"
    else
        echo "Error breaking"
        break   # network up
    fi
    sleep 1800
done
