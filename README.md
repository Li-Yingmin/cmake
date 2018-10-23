test case from cmake-practice
## some tips
1. 默认的cmake_install_prefix
/usr/local

2. 根目录才有PROJECT(HELLO)

`<PROJECTNAME>_BINARY_DIR` == `PROJECT_BINARY_DIR`  #指的是编译目录，一般是指 project_root_dir/build/，即makefile的生成目录
`<PROJECTNAME>_SOURCE_DIR` == `PROJECT_SOURCE_DIR`  #指的是源代码目录，一般是 project_root_dir

3. 在哪里添加的add就在哪里set PATH

```
ADD_LIBRARY(hello SHARED ${LIBHELLO_SRC})
SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib_so)
```

4. 给add_subdirectory的目录重命名

```
ADD_SUBDIRECTORY(lib subdir_lib)
```

如果在lib目录里的CMakeLists.txt里没有set path，那么就会在build/subdir_lib里生成目标文件