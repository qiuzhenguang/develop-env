#build nginx-1.8.1 and pcre

#download nginx-1.8.1

wget http://nginx.org/download/nginx-1.8.1.tar.gz 

tar -xzvf nginx-1.8.1.tar.gz 

#configure

cd nginx-1.8.1 

PWD=`pwd`

./configure  --without-http_rewrite_module --with-debug

make


#conf:
sed -i "s/listen       80;/listen       8501;/g" ./conf/nginx.conf
sed -i "s/#error_log  logs\/error.log  info;/error_log  logs\/error.log  debug_http;/g" ./conf/nginx.conf
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



