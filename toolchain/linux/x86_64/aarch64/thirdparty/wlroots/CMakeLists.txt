set(TARGET_NAME wlroots)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include
    ${TC_INSTALL_DIR}/include/pixman-1
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/libwlroots.so
    ${TC_INSTALL_DIR}/lib/libwayland-server.so
    ${TC_INSTALL_DIR}/lib/libxkbcommon.so
)
