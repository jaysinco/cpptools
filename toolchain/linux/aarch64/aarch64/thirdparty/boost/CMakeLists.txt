set(TARGET_NAME boost)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/libboost_program_options.so
    ${TC_INSTALL_DIR}/lib/libboost_timer.so
    ${TC_INSTALL_DIR}/lib/libboost_chrono.so
)
