if(NOT DEFINED PROJ_PATH)
  message(FATAL_ERROR "Please include the `PROJ_PATH`")
endif()

if (DEFINED DEBUG)
  message("Adding 'cmsis.a'.")
endif()

add_library(cmsis INTERFACE)
target_include_directories(cmsis INTERFACE ${PROJ_PATH}/gecko_sdk/platform/CMSIS/Core/Include)
