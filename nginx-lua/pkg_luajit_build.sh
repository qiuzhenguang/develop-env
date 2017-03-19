#https://github.com/openresty/lua-nginx-module#installation

#Download nginx pcre LuaJIT nginx_devel_kit ngx_lua

#download nginx-1.8.1
#https://github.com/nginx/nginx/commits/master/src/core/ngx_cycle.h  
#From the history we see, before Mar 4, 2015, no member named noreuse in ngx_shm_zone_t, so we use nginx-1.11.10
wget http://nginx.org/download/nginx-1.11.10.tar.gz
tar -xzvf nginx-1.11.10.tar.gz 

#download pcre
#must add pcre, because ngx_devel_kit need http_rewrite_module/ngx_http_rewrite_module
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz --no-check-certificate
tar -xzvf pcre-8.40.tar.gz

#download LuaJIT
wget http://luajit.org/download/LuaJIT-2.1.0-beta2.tar.gz
tar -xzvf LuaJIT-2.1.0-beta2.tar.gz

#download ngx_devel_kit
wget https://github.com/simpl/ngx_devel_kit/archive/v0.3.0.tar.gz --no-check-certificate
tar -xzvf v0.3.0.tar.gz

wget https://github.com/openresty/lua-nginx-module/archive/v0.10.7.tar.gz  --no-check-certificate
tar -xzvf v0.10.7.tar.gz

cd ./LuaJIT-2.1.0-beta2
PWD=`pwd`
make DPREFIX=$PWD
make install DPREFIX=$PWD
cd -

cd nginx-1.11.10
PWD=`pwd`
sed -i "s/disable-shared/disable-shared enable_cpp=no/g"  ./auto/lib/pcre/make

export LUAJIT_LIB=$PWD/../LuaJIT-2.1.0-beta2/lib
export LUAJIT_INC=$PWD/../LuaJIT-2.1.0-beta2/include/luajit-2.1

#configure
./configure \
         --with-ld-opt="-Wl,-rpath,$PWD/../LuaJIT-2.1.0-beta2/lib" \
         --add-module=$PWD/../ngx_devel_kit-0.3.0 \
         --add-module=$PWD/../lua-nginx-module-0.10.7  \
         --with-pcre=$PWD/../pcre-8.40/ 

make 

#conf:
sed -i "s/listen       80;/listen       8501;/g" ./conf/nginx.conf
sed -i "s/#error_log/error_log/g" ./conf/nginx.conf
sed -i "s/root   html;/content_by_lua 'ngx.say(\"Hello LuaJIT\")';/g" ./conf/nginx.conf

mkdir logs
touch logs/error.log

objs/nginx  -c conf/nginx.conf  -p .
ps -ef | grep `cat logs/nginx.pid`

curl http://127.0.0.1:8501/

objs/nginx  -c conf/nginx.conf -p . -s stop
ps -ef | grep `cat logs/nginx.pid`

