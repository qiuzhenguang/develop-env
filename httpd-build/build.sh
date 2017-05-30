#build httpd

wget https://archive.apache.org/dist/httpd/httpd-2.2.25.tar.gz  --no-check-certificate

tar -xzvf httpd-2.2.25.tar.gz

cd httpd-2.2.25

./configure

make

mkdir conf

mkdir logs

mkdir htdocs

echo aaaaaaaa > htdocs/a.txt


cd conf/

cp ../docs/conf/httpd.conf httpd.conf.mod
cp httpd.conf.mod httpd.conf

cat httpd.conf.mod | sed "s/\@\@ServerRoot\@\@/\.\//g" > httpd.conf
cp httpd.conf httpd.conf.mod

cat httpd.conf.mod | sed "s/\@\@Port\@\@/8099/g" > httpd.conf
cp httpd.conf httpd.conf.mod

cat httpd.conf.mod | sed "s/\@\@LoadModule\@\@//g" > httpd.conf
cp httpd.conf httpd.conf.mod

cat httpd.conf.mod | sed "s/\/usr\/local\/apache2\//\.\//g" > httpd.conf
cp httpd.conf httpd.conf.mod

cat httpd.conf.mod | sed "s/Deny from all/Allow from all/g" > httpd.conf
rm httpd.conf.mod

cd ../


cp ./docs/conf/mime.types ./conf/

./httpd -d ./
curl http://localhost:8099/a.txt

ps -ef | grep httpd
killall lt-httpd
sleep 1
ps -ef | grep httpd

