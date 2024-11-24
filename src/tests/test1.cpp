#include "gtest\gtest.h"
#include "gmock\gmock.h"
#include "cal.h"

// 测试加法
TEST(CalculatorTest, AddTest) {
    Calculator calc;
    EXPECT_EQ(calc.add(3, 4), 5); // 3 + 2 = 5
    EXPECT_EQ(calc.add(-1, 1), 0); // -1 + 1 = 0
    EXPECT_EQ(calc.add(-1, -1), -2); // -1 + -1 = -2
}

// 测试减法
TEST(CalculatorTest, SubtractTest) {
    Calculator calc;
    EXPECT_EQ(calc.subtract(3, 2), 1); // 3 - 2 = 1
    EXPECT_EQ(calc.subtract(-1, 1), -2); // -1 - 1 = -2
    EXPECT_EQ(calc.subtract(-1, -1), 0); // -1 - -1 = 0
}

// 测试乘法
TEST(CalculatorTest, MultiplyTest) {
    Calculator calc;
    EXPECT_EQ(calc.multiply(3, 2), 6); // 3 * 2 = 6
    EXPECT_EQ(calc.multiply(-1, 1), -1); // -1 * 1 = -1
    EXPECT_EQ(calc.multiply(-1, -1), 1); // -1 * -1 = 1
}


