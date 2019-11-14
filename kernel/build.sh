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


#FATAL: Module fuse not found.
#https://github.com/s3fs-fuse/s3fs-fuse/issues/647

#运行depmod -a重新配置依赖关系，以后就可以通过modprobe fuse来加载fuse模块了。

#CentOS 6.10的内核：
#http://vault.centos.org/6.10/os/Source/SPackages/kernel-2.6.32-754.el6.src.rpm


#单独编译某个内核模块(fuse)[转]
#http://blog.sina.com.cn/s/blog_553c6d4e0101fze4.html
