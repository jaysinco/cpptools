set(TARGET_NAME ftxui)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/libftxui-screen.so
    ${TC_INSTALL_DIR}/lib/libftxui-dom.so
    ${TC_INSTALL_DIR}/lib/libftxui-component.so
)
