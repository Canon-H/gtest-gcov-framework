# gtest_gcov_framework

Framework for software testing using Google Test and Gcov tools in Windows + CMake + MinGW64 environment, placing the project files and test cases in the corresponding paths for testing.

## Required Environment

- Use the latest version of GCC (I used 14.2; version 8.1 on Windows with MinGW had multithreading issues, which were resolved after upgrading).
- Python.

## Steps to Run

Run the batch script directly.

## Explanation

1. When compiling gtest and gmock with GCC, the local Windows MinGW version 8.1 has multithreading issues. Upgrading to a newer version resolves this problem.
2. Code coverage uses the gcov+gcovr toolchain. Gcov is part of GCC, while gcovr requires Python. Set up the environment variables, and after installing the gcovr library via `pip install gcovr`, you can follow the usage instructions. 


## Usage Instructions

### 1. Folder Structure

 1. build：Saves the compiled files. The executable and redirected test results (test_reports.txt) are found in `build\bin`. The build folder is automatically generated when running the batch script; it will be deleted and recreated upon rerunning.

 2. coverage：Stores the generated HTML file for code coverage tests after execution.

 3. include：Contains the necessary headers for `src\funcs` and `src\tests`.

 4. lib：Contains the static link libraries for gtest and gmock.

 5. src：Project folder
    i. funcs：Contains files for each test function module.

    ii. main 

    iii. tests：Stores headers and test cases.
    	gmock：Contains gmock-r：Stores headers and test cases.
    	gmock：Contains gtest-related headers.
    
 6. build_gcovr.bat：Executes coverage tests upon running.

 7. build_test.bat：Runs without executing coverage tests.

### 2. Additional Information

1. In `src\main\CMakeLists.txt`, set the executable filename on line 17.
2. Set the corresponding executable filename on line 7 in the batch script.
3. When debugging with VSCode: Update the `program` path in `launch.json` to the executable file path and adjust `miDebuggerPath` to the MinGW path; change `command` in `tasks.json` to the MinGW path.
4. For terminal step-by-step execution: In the build folder, run `cmake .. -G "MinGW Makefiles" -D ENABLE_COVERAGE=ON`; `mingw32-make`; after executing the executable, generate `.gcda` and `.gcno` files, move them to the source file directory; run `gcov` to generate `.gcov` files; use `gcovr -r . --html --html-details -o coverage.html` to generate the coverage HTML file.
5. In the launch.json , set `args` to `--gtest_break_on_failure` to break on failure during gtest debugging.
