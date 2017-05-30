#build nginx-1.11.10 and openssl

#download nginx-1.11.10

wget http://nginx.org/download/nginx-1.11.10.tar.gz 

tar -xzvf nginx-1.11.10.tar.gz 

#download pcre
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz --no-check-certificate
tar -xzvf pcre-8.40.tar.gz

#download openssl
wget https://www.openssl.org/source/openssl-1.0.2h.tar.gz  --no-check-certificate
tar -xzvf openssl-1.0.2h.tar.gz

#build openssl
#cd openssl-1.0.2h
#PWD=`pwd`
#./config --prefix=$PWD/.openssl
#make
#make install
#cd -

#configure

cd nginx-1.11.10 

PWD=`pwd`
sed -i "s/disable-shared/disable-shared enable_cpp=no/g" ./auto/lib/pcre/make

./configure  \
--with-pcre=$PWD/../pcre-8.40/   \
--with-openssl=$PWD/../openssl-1.0.2h \
--with-http_ssl_module

#!!!! must add http_ssl_module, or the openssl will not build !!!!

make


#conf:
sed -i "s/listen       80;/listen       8501;/g" ./conf/nginx.conf
mkdir logs
touch logs/error.log

#gen openssl keys:

#openssl genrsa -des3 -out server.key 1024
#openssl req -new -key server.key -out server.csr
#cp server.key server.key.org
#openssl rsa -in server.key.org -out server.key
#openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt


#run:
#Test nginx.conf:
./objs/nginx -t -c conf/nginx.conf -p .

#Run Nginx:
./objs/nginx -c conf/nginx.conf -p .
ps -ef | grep `cat logs/nginx.pid`

#Test mytest module
curl http://localhost:8501/index.html


#Stop Nginx:
./objs/nginx -s stop -c conf/nginx.conf -p .


#I dont know how to build it, because in the objs/Makefile, the obj doesnt depend on openssl.

#HaHa~~, I get it done!  We MUST enable http_ssl_module module to make openssl build inside.



