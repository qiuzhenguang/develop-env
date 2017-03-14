#https://github.com/openresty/lua-nginx-module#installation

#OpenResty bundle

#Download openresty
#openresty-1.11.2.2.tar.gz   4.1MB   PGP   Changes - 17 November 2016

wget https://openresty.org/download/openresty-1.11.2.2.tar.gz --no-check-certificate
tar -xzvf openresty-1.11.2.2.tar.gz

#download pcre
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz --no-check-certificate
tar -xzvf pcre-8.40.tar.gz

#download openssl
#wget https://www.openssl.org/source/openssl-1.1.0e.tar.gz  --no-check-certificate
#tar -xzvf openssl-1.1.0e.tar.gz

cd openresty-1.11.2.2

PWD=`pwd`

sed -i "s/disable-shared/disable-shared enable_cpp=no/g"  ./bundle/nginx-1.11.2/auto/lib/pcre/make

./configure --with-luajit \
 --with-pcre=$PWD/../pcre-8.40/  \
 --without-http_ssl_module \
 --prefix=$PWD/nginx

# --with-openssl=$PWD/../openssl-1.1.0e/   \

make 
make install

cd nginx/nginx

#conf:
sed -i "s/listen       80;/listen       8501;/g" ./conf/nginx.conf
sed -i "s/root   html;/content_by_lua 'ngx.say(\"Hello Lua\")';/g" ./conf/nginx.conf


sbin/nginx  -c conf/nginx.conf 
ps -ef | grep `cat logs/nginx.pid`

curl http://127.0.0.1:8501/

sbin/nginx  -c conf/nginx.conf  -s stop
ps -ef | grep `cat logs/nginx.pid`


