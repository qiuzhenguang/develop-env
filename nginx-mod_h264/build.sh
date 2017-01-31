#build nginx-1.8.1 and nginx_mod_h264_streaming

#download nginx-1.8.1

wget http://nginx.org/download/nginx-1.8.1.tar.gz 

tar -xzvf nginx-1.8.1.tar.gz 

#download nginx_mod_h264_streaming

wget https://github.com/drmingdrmer/nginx_mod_h264_streaming/archive/2.3.2.tar.gz -O 2.3.2.tar.gz

tar -xzvf 2.3.2.tar.gz

#download pcre
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz
tar -xzvf pcre-8.40.tar.gz

#configure

cd nginx-1.8.1 

PWD=`pwd`

./configure  \
--add-module=$PWD/../nginx_mod_h264_streaming-2.3.2/  \
--with-pcre=$PWD/../pcre-8.40/

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



#add some logs to nginx_mod_h264_streaming

#1. nginx_mod_h264_streaming-2.3.2/src/ngx_http_streaming_module.c   Line:264
  #if(r->args.len) {
  #    ngx_log_debug(NGX_LOG_DEBUG_CORE, log, 0, "Go here, r->args=%V, %s, %d", &(r->args),  __FILE__, __LINE__);
  #} else {
  #    ngx_log_debug(NGX_LOG_DEBUG_CORE, log, 0, "Go here, r->args.len=0, %s, %d", __FILE__, __LINE__);
  #}


#2. nginx_mod_h264_streaming-2.3.2/src/moov.c   Line:143, 173
        #mp4_log_trace("ts=%.2f (seconds)\n",
        #         trak->samples_[sample_index].pts_ / (float)trak_time_scale);


#moov.c Line:184   mp4_log_trace("final start=%"PRId64"\n", start);
#moov.c Line:185   mp4_log_trace("final end=%"PRId64"\n", end);

#3.mp4_io.c
#Line:71  freopen("/home/work/qiuzhenguang/mp4/nginx/nginx-1.8.1/logs/module.log", "a", stdout);
#Line:77  fflush(stdout);

#4.moov.c
#Line: 271, Line: 276, function mp4_split_options_set, modify "ts" to "start", "te" to "end"







