#build gtest

#download gtest

wget https://github.com/google/googletest/archive/release-1.7.0.tar.gz -O ./gtest-1.7.0.tar.gz
mkdir gtest
tar -xzvf gtest-1.7.0.tar.gz -C gtest

echo '#include <gtest/gtest.h>

TEST(AAAAAA, BBBBB) {
    EXPECT_EQ(1234, 1234);
}' > test.cpp


CXX=g++
GTEST_DIR=gtest/googletest-release-1.7.0
CPPFLAGS=-I$GTEST_DIR/include
g++ $CPPFLAGS -g -Wall -Wextra -c test.cpp
g++ $CPPFLAGS -I$GTEST_DIR -g -Wall -Wextra -c $GTEST_DIR/src/gtest-all.cc
g++ $CPPFLAGS -I$GTEST_DIR -g -Wall -Wextra -c $GTEST_DIR/src/gtest_main.cc
ar rv gtest_main.a gtest-all.o gtest_main.o
g++ -I../include -g -Wall -Wextra -lpthread test.o gtest_main.a -o test
 
./test
