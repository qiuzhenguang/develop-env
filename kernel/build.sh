PKG=linux-3.10.11
wget https://www.kernel.org/pub/linux/kernel/v3.0/$PKG.tar.bz2
sleep 5

tar -xf $PKG.tar.bz2
sleep 5

cd $PKG

sed -i -e 's/unsigned long newsize = roundup_pow_of_two(size);/unsigned long newsize = roundup_pow_of_two(size);\n        printk(KERN_ERR "DEBUG_BY_QIUZHENGUANG.\\n");/g'  mm/readahead.c

date >> log.txt
echo "Start ..." >>log.txt

echo "Start make mrproper ..." >>log.txt
echo ===========================  >>log.txt
date >> log.txt
make mrproper >> log.txt 2>&1
sleep 5

echo "Start make defconfig ..." >>log.txt
echo ===========================  >> log.txt
date >> log.txt
make defconfig  >> log.txt 2>&1
sleep 5

echo "Start make clean ..." >>log.txt
echo ===========================  >> log.txt
date >> log.txt
make clean >> log.txt 2>&1
sleep 5

echo "Start make bzImage ..." >>log.txt
echo ===========================  >> log.txt
date >> log.txt
make -j32 bzImage >> log.txt 2>&1
sleep 5

echo "Start make modules ..." >>log.txt
echo ===========================  >> log.txt
date >> log.txt
make -j32 modules >> log.txt 2>&1
sleep 5

echo "Start make modules_install ..." >>log.txt
echo ===========================  >> log.txt
date >> log.txt
#make modules_install >> log.txt 2>&1
sleep 5

echo "Start make install ..." >>log.txt
echo ===========================  >> log.txt
date >> log.txt
#make install  >> log.txt 2>&1
sleep 5


date >> log.txt

