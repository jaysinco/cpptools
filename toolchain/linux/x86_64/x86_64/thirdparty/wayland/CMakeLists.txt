set(TARGET_NAME wayland)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/libwayland-client.so
    ${TC_INSTALL_DIR}/lib/libwayland-cursor.so
    ${TC_INSTALL_DIR}/lib/libwayland-egl.so
)
