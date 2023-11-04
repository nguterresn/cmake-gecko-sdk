if(NOT DEFINED PROJ_PATH)
  message(FATAL_ERROR "Please include the `PROJ_PATH`")
endif()

if (DEFINED DEBUG)
  message("Adding 'emdrv.a'.")
endif()

set(emdrv_INCLUDE
  ${PROJ_PATH}/gecko_sdk/platform/driver/leddrv/inc
  ${PROJ_PATH}/config
)

set(emdrv_SRC
  ${PROJ_PATH}/gecko_sdk/platform/driver/leddrv/src/sl_led.c
  ${PROJ_PATH}/gecko_sdk/platform/driver/leddrv/src/sl_simple_led.c
)

add_library(emdrv ${emdrv_SRC})
target_include_directories(emdrv PUBLIC ${emdrv_INCLUDE})
target_link_libraries(emdrv PUBLIC device slcommon emlib)
