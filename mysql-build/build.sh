wget https://downloads.mysql.com/archives/get/file/mysql-5.1.63.tar.gz --no-check-certificate

tar -xzvf mysql-5.1.63.tar.gz

myPWD=`pwd`
echo $myPWD

cd mysql-5.1.63
./configure --prefix=$myPWD/mysql --with-plugins=innobase,partition

make
make install

mkdir $myPWD/mysql/var

chmod 777 /var/lib/mysql/

$myPWD/mysql/bin/mysql_install_db --user=mysql

$myPWD/mysql/bin/mysqld_safe --defaults-file=/etc/my.cnf  --user=root

$myPWD/mysql/bin/mysqladmin shutdown -uroot -S /var/lib/mysql/mysql.sock


