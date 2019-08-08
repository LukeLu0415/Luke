#!/bin/bash
sed -i "s/\"server\":\"0.0.0.0\"/\"server\":\"::\"/g" /etc/shadowsocks.json
/etc/init.d/shadowsocks restart
service ip6tables stop
echo "#!/bin/bash" > /root/ipv6.sh
echo "ifconfig sit0 up" >> /root/ipv6.sh
echo "ifconfig sit0 inet6 tunnel ::66.220.18.42" >> /root/ipv6.sh
echo "ifconfig sit1 up" >> /root/ipv6.sh
echo "ifconfig sit1 inet6 add 2001:470:c:60::2/64" >> /root/ipv6.sh
echo "route -A inet6 add ::/0 dev sit1" >> /root/ipv6.sh
chmod +x /root/ipv6.sh
echo "sh /root/ipv6.sh" >> /etc/rc.d/rc.local
echo "service ip6tables stop" >> /etc/rc.d/rc.local
wget --no-check-certificate https://raw.githubusercontent.com/tcp-nanqinlang/general/master/General/CentOS/bash/tcp_nanqinlang-1.3.2.sh