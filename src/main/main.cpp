#include<iostream>
#include "gtest\gtest.h"
using namespace std;

// 主函数，运行所有测试
int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
