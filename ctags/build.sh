 wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz --no-check-certificate
 tar -xzvf ctags-5.8.tar.gz 
 cd ctags-5.8
 ./configure 
 make
 #ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . 
