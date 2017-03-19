#https://github.com/openresty/lua-nginx-module#installation

#Download nginx pcre Lua5.1 nginx_devel_kit ngx_lua

#download nginx-1.8.1
#https://github.com/nginx/nginx/commits/master/src/core/ngx_cycle.h  
#From the history we see, before Mar 4, 2015, no member named noreuse in ngx_shm_zone_t, so we use nginx-1.11.10
wget http://nginx.org/download/nginx-1.11.10.tar.gz
tar -xzvf nginx-1.11.10.tar.gz 

#download pcre
#must add pcre, because ngx_devel_kit need http_rewrite_module/ngx_http_rewrite_module
wget https://ftp.pcre.org/pub/pcre/pcre-8.40.tar.gz -O pcre-8.40.tar.gz --no-check-certificate
tar -xzvf pcre-8.40.tar.gz

#download Lua5.1
wget http://www.lua.org/ftp/lua-5.1.5.tar.gz
tar -xzvf lua-5.1.5.tar.gz

#download ngx_devel_kit
wget https://github.com/simpl/ngx_devel_kit/archive/v0.3.0.tar.gz -O v0.3.0.tar.gz --no-check-certificate
tar -xzvf v0.3.0.tar.gz

wget https://github.com/openresty/lua-nginx-module/archive/v0.10.7.tar.gz  -O v0.10.7.tar.gz --no-check-certificate
tar -xzvf v0.10.7.tar.gz

cd ./lua-5.1.5
PWD=`pwd`
make linux
make local
cd -

cd nginx-1.11.10
PWD=`pwd`
sed -i "s/disable-shared/disable-shared enable_cpp=no/g"  ./auto/lib/pcre/make

export LUA_LIB=$PWD/../lua-5.1.5/lib
export LUA_INC=$PWD/../lua-5.1.5/include

#configure
./configure \
         --with-ld-opt="-Wl,-rpath,$PWD/../lua-5.1.5/lib" \
         --add-module=$PWD/../ngx_devel_kit-0.3.0 \
         --add-module=$PWD/../lua-nginx-module-0.10.7  \
         --with-pcre=$PWD/../pcre-8.40/ 

make 

#conf:
sed -i "s/listen       80;/listen       8501;/g" ./conf/nginx.conf
sed -i "s/#error_log/error_log/g" ./conf/nginx.conf
sed -i "s/root   html;/content_by_lua 'ngx.say(\"Hello Lua5.1.5\")';/g" ./conf/nginx.conf

mkdir logs
touch logs/error.log

objs/nginx  -c conf/nginx.conf  -p .
ps -ef | grep `cat logs/nginx.pid`

curl http://127.0.0.1:8501/

objs/nginx  -c conf/nginx.conf -p . -s stop
ps -ef | grep `cat logs/nginx.pid`

