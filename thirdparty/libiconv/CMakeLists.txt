set(TARGET_NAME libiconv)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/libiconv.so
)
