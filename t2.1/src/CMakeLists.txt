CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
ADD_EXECUTABLE(hello main.c)
INSTALL(TARGETS hello
        RUNTIME DESTINATION bin)