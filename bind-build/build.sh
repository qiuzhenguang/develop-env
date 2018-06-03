#bind-build.sh

#wget "https://www.isc.org/downloads/file/bind-9-9-9-p3/?version=tar-gz" -O bind-9.9.9-P3.tar.gz
#cp /tmp/bind-9.9.9-P3.tar.gz  ./

tar -xzvf bind-9.9.9-P3.tar.gz

mkdir bind_install

MY_PWD=`pwd`

cd bind-9.9.9-P3

./configure --prefix=$MY_PWD/bind_install

make

make install

cd -

cd bind_install

./sbin/rndc-confgen > etc/rndc.conf

rndc_key=`cat etc/rndc.conf  | grep secret | awk -F"\"" '{print $2}' | head -n 1`;

echo  '
key "rndc-key" {
	algorithm hmac-md5;
	secret "'$rndc_key'";
};

controls {
	inet 127.0.0.1 port 953
		allow { 127.0.0.1; } keys { "rndc-key"; };
};

options {
	directory "'$MY_PWD'/bind_install/var";
	pid-file "named.pid";
};

zone "cobb.com" IN {
	type master;
	file "cobb.com.zone";
	allow-update { none; };
};

' > etc/named.conf


echo '
$TTL 86400
$ORIGIN cobb.com.
@       IN  SOA ns1 root(
            2013031901      ;serial
            12h     ;refresh
            7200        ;retry
            604800      ;expire
            86400       ;mininum
            )
            NS  ns1.cobb.com.
            NS  ns2.cobb.net.
            MX  10  mail.cobb.com.
ns1     IN  A   192.168.10.1
www     IN  A   192.168.10.10
        IN  A   192.168.10.11
mail        IN  A   192.168.10.20
ljx     IN  A   192.168.10.30
ftp     IN  CNAME   ljx

' > ./var/cobb.com.zone


#! must run by root
#su root

./sbin/named -c ./etc/named.conf

dig www.cobb.com @127.1




