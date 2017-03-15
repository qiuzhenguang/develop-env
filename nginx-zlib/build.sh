#build nginx-1.8.1 and pcre

#download nginx-1.8.1

wget http://nginx.org/download/nginx-1.8.1.tar.gz 

tar -xzvf nginx-1.8.1.tar.gz 

#download pcre
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz --no-check-certificate
tar -xzvf pcre-8.40.tar.gz

#download zlib
wget http://www.zlib.net/zlib-1.2.11.tar.gz
tar -xzvf zlib-1.2.11.tar.gz
#configure

cd nginx-1.8.1 

PWD=`pwd`

sed -i "s/disable-shared/disable-shared enable_cpp=no/g" ./auto/lib/pcre/make

./configure  \
--with-pcre=$PWD/../pcre-8.40/  \
--with-zlib=$PWD/../zlib-1.2.11/  

make


#conf:
sed -i "s/listen       80;/listen       8501;/g" ./conf/nginx.conf
sed -i "s/#gzip/gzip/g" ./conf/nginx.conf
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



