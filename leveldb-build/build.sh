 git clone https://github.com/google/leveldb.git
 cd leveldb/
 mkdir -p build
 cd build/
 cmake ..
 make

cd leveldb
mkdir app
cd app/
vim app_test.cc

vim ../CMakeLists.txt 
#if(NOT BUILD_SHARED_LIBS)
#+    leveldb_test("${PROJECT_SOURCE_DIR}/app/app_test.cc")cd ../build/

cmake  -DCMAKE_BUILD_TYPE=Debug ..
make
./app_test 
gdb ./app_test

#https://zhuanlan.zhihu.com/p/34657032
