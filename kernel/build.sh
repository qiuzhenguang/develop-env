PKG=linux-3.10.13
wget https://www.kernel.org/pub/linux/kernel/v3.0/$PKG.tar.bz2
sleep 5

echo ===========================  >> log.txt
date >> log.txt
echo "Start tar ..." >>log.txt

tar -xf $PKG.tar.bz2
sleep 5

cd $PKG

echo "Start make mrproper ..." >>../log.txt
echo ===========================  >> ../log.txt
make mrproper >> ../log.txt 2>&1
sleep 5

echo "Start make defconfig ..." >>../log.txt
echo ===========================  >> ../log.txt
make defconfig  >> ../log.txt 2>&1
sleep 5

echo "Start make clean ..." >>../log.txt
echo ===========================  >> ../log.txt
make clean >> ../log.txt 2>&1
sleep 5

echo "Start make bzImage ..." >>../log.txt
echo ===========================  >> ../log.txt
make bzImage >> ../log.txt 2>&1
sleep 5

echo "Start make modules ..." >>../log.txt
echo ===========================  >> ../log.txt
make modules >> ../log.txt 2>&1
sleep 5

echo "Start make modules_install ..." >>../log.txt
echo ===========================  >> ../log.txt
make modules_install >> ../log.txt 2>&1
sleep 5

echo "Start make install ..." >>../log.txt
echo ===========================  >> ../log.txt
make install  >> ../log.txt 2>&1
sleep 5


date >> ../log.txt



