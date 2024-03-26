set(TARGET_NAME opencv)

add_library(${TARGET_NAME} INTERFACE)

target_include_directories(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/include/opencv4
)

target_link_libraries(${TARGET_NAME} INTERFACE
    ${TC_INSTALL_DIR}/lib/opencv_core481.lib
    ${TC_INSTALL_DIR}/lib/opencv_ximgproc481.lib
    ${TC_INSTALL_DIR}/lib/opencv_imgproc481.lib
    ${TC_INSTALL_DIR}/lib/opencv_imgcodecs481.lib
)
