set(TARGET_NAME wlroots)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    /usr/include/wlroots0.17
    /usr/include/pixman-1
)

target_link_libraries(${TARGET_NAME} INTERFACE
    /usr/lib/wlroots0.17/libwlroots.so
    /usr/lib/libwayland-server.so
    /usr/lib/libxkbcommon.so
)
