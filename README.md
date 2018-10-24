test case from cmake-practice
## some tips
1. 默认的CMAKE_INSTALL_PREFIX
/usr/local

2. 根目录才有project(HELLO)

`<PROJECTNAME>_BINARY_DIR` == `PROJECT_BINARY_DIR`  #指的是编译目录，一般是指 project_root_dir/build/，即makefile的生成目录
`<PROJECTNAME>_SOURCE_DIR` == `PROJECT_SOURCE_DIR`  #指的是源代码目录，一般是 project_root_dir

3. 在哪里添加的add就在哪里set PATH

```
add_library(hello SHARED ${LIBHELLO_SRC})
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib_so)
```

4. 给add_subdirectory的目录重命名

```
add_subdirectory(lib subdir_lib)
```

如果在lib目录里的CMakeLists.txt里没有set path，那么就会在build/subdir_lib里生成目标文件，在build目录也会创建subdir_lib目录

5. version要求
```
cmake_minimum_required(VERSION 2.8)
```

6. add_library
```
add_library(hello STATIC ${LIBHELLO_SRC})
add_library(hello SHARED ${LIBHELLO_SRC})
```

7. set_target_properties

```
set_target_properties(hello_static PROPERTIES OUTPUT_NAME "hello")
get_target_property(OUTPUT_VALUE hello_static OUTPUT_NAME)
message(STATUS "This is the hello_static OUTPUT_NAME:" ${OUTPUT_VALUE})
set_target_properties(hello PROPERTIES CLEAN_DIRECT_OUTPUT 1)
set_target_properties(hello_static PROPERTIES CLEAN_DIRECT_OUTPUT 1)
set_target_properties(hello PROPERTIES VERSION 1.2 SOVERSION 1)
```

这里的OUTPUT_NAME不是自定义的，是一个属性，CLEAN_DIRECT_OUTPUT也是这样


8. install
```
install(FILES xxx xxx DESTINATION share/doc/cmake/t2)
install(PROGRAMS xx.sh DESTINATION bin)
install(TARGETS hello hello_static
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)
```

9. 搜索路径
```
set(CMAKE_INCLUDE_DIRECTORIES_BEFORE on)  #将路径添加到已有路径之前
include_directories(/usr/local/include/hello /usr/local/include/hello2) #非标准头文件的路径，空格分割
link_directories(dir1 dir2) #添加非标准共享库的路径
target_link_libraries(main hello)  #会自动去寻找.so
or target_link_libraries(main libhello.so)
target_link_libraries(main libhello.a)  #静态库
```

在执行的时候，要先执行一下ldconfig指令才能找到动态或者静态库
```
ldd bin/main #查看链接情况
```

10. 路径环境变量
```
export CMAKE_INCLUDE_PATH=/usr/local/include/hello
find_path(myHeader hello.h)
if(myHeader)
include_directories(${myHeader})
endif(myHeader)

CMAKE_LIBRARY_PATH  find_library
```