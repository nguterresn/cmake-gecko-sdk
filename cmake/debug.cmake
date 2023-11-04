if(NOT DEFINED PROJ_PATH)
message(FATAL_ERROR "Please include the `PROJ_PATH`")
endif()

if (DEFINED DEBUG)
  message("Adding 'debug_swo.a'.")
endif()

add_library(debug_swo
  ${PROJ_PATH}/gecko_sdk/platform/driver/debug/src/sl_debug_swo.c
  ${PROJ_PATH}/gecko_sdk/hardware/driver/configuration_over_swo/src/sl_cos.c
)
target_include_directories(debug_swo PUBLIC
  ${PROJ_PATH}/gecko_sdk/platform/driver/debug/inc
  ${PROJ_PATH}/gecko_sdk/hardware/driver/configuration_over_swo/inc
  ${PROJ_PATH}/config
)
target_link_libraries(debug_swo slcommon emlib)
