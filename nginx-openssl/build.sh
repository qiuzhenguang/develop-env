#build nginx-1.8.1 and openssl

#download nginx-1.8.1

wget http://nginx.org/download/nginx-1.8.1.tar.gz 

tar -xzvf nginx-1.8.1.tar.gz 

#download openssl
wget https://www.openssl.org/source/openssl-1.1.0e.tar.gz  --no-check-certificate
tar -xzvf penssl-1.1.0e.tar.gz

#configure

cd nginx-1.8.1 

PWD=`pwd`

./configure  \
--with-openssl=$PWD/../penssl-1.1.0e/   \
--without-http_rewrite_module

make


#conf:
sed -i "s/listen       80;/listen       8501;/g" ./conf/nginx.conf
mkdir logs
touch logs/error.log

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


# This file is not test ok.

