set(TARGET_NAME boost)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/boost_program_options.lib
)

target_compile_definitions(${TARGET_NAME} INTERFACE
    BOOST_ALL_NO_LIB
    BOOST_ALL_DYN_LINK
)
