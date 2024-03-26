set(TARGET_NAME opencv)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include/opencv4
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/libopencv_core.so
    ${TC_INSTALL_DIR}/lib/libopencv_imgproc.so
    ${TC_INSTALL_DIR}/lib/libopencv_ximgproc.so
    ${TC_INSTALL_DIR}/lib/libopencv_imgcodecs.so
)
