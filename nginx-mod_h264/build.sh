#build nginx-1.8.1 and nginx_mod_h264_streaming

#download nginx-1.8.1

wget http://nginx.org/download/nginx-1.8.1.tar.gz 

tar -xzvf nginx-1.8.1.tar.gz 

#download nginx_mod_h264_streaming

wget https://github.com/drmingdrmer/nginx_mod_h264_streaming/archive/2.3.2.tar.gz -O 2.3.2.tar.gz

tar -xzvf 2.3.2.tar.gz

#configure

cd nginx-1.8.1 

PWD=`pwd`

./configure  \
--add-module=$PWD/../nginx_mod_h264_streaming-2.3.2/ 

make


#conf:
sed -i "s/listen       80;/listen       8501;/g" ./conf/nginx.conf
sed -i '44i\           mp4;' ./conf/nginx.conf
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
curl "http://localhost:8501/a.mp4?ts=5&te=20" -svo /dev/null


#Stop Nginx:
./objs/nginx -s stop -c conf/nginx.conf -p .

