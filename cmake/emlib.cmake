if(NOT DEFINED PROJ_PATH)
  message(FATAL_ERROR "Please include the `PROJ_PATH`")
endif()

if(DEFINED DEBUG)
  message("Adding 'emlib.a'.")
endif()

set(emlib_INCLUDE
  ${PROJ_PATH}/gecko_sdk/platform/emlib/inc
  ${PROJ_PATH}/gecko_sdk/platform/common/inc
  ${PROJ_PATH}/gecko_sdk/platform/emlib/host/inc
  ${PROJ_PATH}/gecko_sdk/platform/emlib/config
)

file(GLOB emlib_SRC CONFIGURE_DEPENDS
  ${PROJ_PATH}/gecko_sdk/platform/emlib/src/*.c
  ${PROJ_PATH}/gecko_sdk/platform/common/src/sl_assert.c
  ${PROJ_PATH}/gecko_sdk/platform/common/src/sl_slist.c
)

add_library(emlib ${emlib_SRC})
target_include_directories(emlib PUBLIC ${emlib_INCLUDE})
target_link_libraries(emlib device iostream)
