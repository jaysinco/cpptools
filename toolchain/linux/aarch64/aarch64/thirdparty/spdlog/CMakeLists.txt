set(TARGET_NAME spdlog)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/libspdlog.so
)

target_compile_definitions(${TARGET_NAME} INTERFACE
    SPDLOG_COMPILED_LIB
    SPDLOG_FMT_EXTERNAL
)
