if(NOT DEFINED PROJ_PATH)
  message(FATAL_ERROR "Please include the `PROJ_PATH`")
endif()

if (DEFINED DEBUG)
  message("Adding 'slcommon.a'.")
endif()

set(slcommon_INCLUDE
  ${PROJ_PATH}/gecko_sdk/platform/common/inc
  ${PROJ_PATH}/gecko_sdk/platform/common/config
  ${PROJ_PATH}/gecko_sdk/platform/common/toolchain/inc
  ${PROJ_PATH}/config
)

set(slcommon_SRC
  ${PROJ_PATH}/gecko_sdk/platform/common/src/sl_assert.c
  ${PROJ_PATH}/gecko_sdk/platform/common/src/sl_slist.c
  ${PROJ_PATH}/gecko_sdk/platform/common/src/sl_status.c
  ${PROJ_PATH}/gecko_sdk/platform/common/toolchain/src/sl_memory.c
)

add_library(slcommon ${slcommon_SRC})
target_include_directories(slcommon PUBLIC ${slcommon_INCLUDE})
target_link_libraries(slcommon device)
