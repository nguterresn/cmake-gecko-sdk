if(NOT DEFINED PROJ_PATH)
  message(FATAL_ERROR "Please include the `PROJ_PATH`")
endif()

if (NOT DEFINED RADIO_BOARD OR NOT DEFINED KIT_BOARD OR NOT DEFINED MODULE)
  message("** No board defined, skipping hardware ** ")
  return()
endif()

if (DEFINED DEBUG)
  message("Board defined. Module [${MODULE}], radio board [${RADIO_BOARD}], kit board [${KIT_BOARD}]")
endif()

add_library(board
  ${PROJ_PATH}/gecko_sdk/hardware/board/src/sl_board_init.c
  ${PROJ_PATH}/gecko_sdk/hardware/board/src/sl_board_control_gpio.c
  ${PROJ_PATH}/gecko_sdk/hardware/driver/mx25_flash_shutdown/src/sl_mx25_flash_shutdown_usart/sl_mx25_flash_shutdown.c
)
target_include_directories(board PUBLIC
  ${PROJ_PATH}/gecko_sdk/hardware/board/inc
  ${PROJ_PATH}/gecko_sdk/hardware/module/config
  ${PROJ_PATH}/gecko_sdk/hardware/driver/mx25_flash_shutdown/inc/sl_mx25_flash_shutdown_usart
  ${PROJ_PATH}/config
  # Kit
  ${PROJ_PATH}/gecko_sdk/hardware/kit/${MODULE}_${RADIO_BOARD}/config
  ${PROJ_PATH}/gecko_sdk/hardware/kit/common/bsp
  ${PROJ_PATH}/gecko_sdk/hardware/kit/common/drivers
  ${PROJ_PATH}/gecko_sdk/hardware/kit/common/halconfig
  # Board config
  ${PROJ_PATH}/gecko_sdk/hardware/board/config/${RADIO_BOARD}_${KIT_BOARD}
)
target_link_libraries(board slcommon emlib udelay)
