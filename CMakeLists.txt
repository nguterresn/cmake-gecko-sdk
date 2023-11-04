cmake_minimum_required(VERSION 3.22)

set(PROJ_PATH                           ${CMAKE_CURRENT_SOURCE_DIR})
# Enable DEBUG or not
set (DEBUG 1)

set(CMAKE_TOOLCHAIN_FILE ${PROJ_PATH}/cmake/gcc-arm-none-eabi.cmake)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if (DEFINED DEBUG)
message("PROJ_PATH: "                 ${PROJ_PATH})
endif()

project(cmake-gecko-sdk)
enable_language(C CXX ASM)

# These variables may vary
set(DEVICE        DBGM220PC22HNA)
set(MODULE        MGM22)
set(RADIO_BOARD   BRD4311B)
set(KIT_BOARD     BRD4002A)

include(cmake/slcommon.cmake)
include(cmake/cmsis.cmake)
include(cmake/device.cmake)
include(cmake/emlib.cmake)
include(cmake/emdrv.cmake)
include(cmake/services.cmake)
include(cmake/board.cmake)
include(cmake/debug.cmake)

set(cmake_gecko_INCLUDE
  # For the code
  ${PROJ_PATH}/gecko_sdk/app/common/app_assert
  ${PROJ_PATH}/gecko_sdk/app/common/util/app_assert
  ${PROJ_PATH}/gecko_sdk/app/common/util/app_log
  ${PROJ_PATH}/gecko_sdk/app/common/util/app_log/config

  # Application
  ${PROJ_PATH}/application/include
  ${PROJ_PATH}/autogen
  ${PROJ_PATH}/config
)

set(cmake_gecko_SRC
  ${PROJ_PATH}/application/src/app.c
  ${PROJ_PATH}/application/src/main.c
  ${PROJ_PATH}/application/src/blink.c
  ${PROJ_PATH}/application/src/syscall.c

  ${PROJ_PATH}/autogen/sl_board_default_init.c
  ${PROJ_PATH}/autogen/sl_event_handler.c
  ${PROJ_PATH}/autogen/sl_device_init_clocks.c

  # LED
  ${PROJ_PATH}/autogen/sl_simple_led_instances.c
)

add_executable(${PROJECT_NAME} ${cmake_gecko_SRC})
target_include_directories(${PROJECT_NAME} PUBLIC ${cmake_gecko_INCLUDE})
target_link_libraries(${PROJECT_NAME}
  cmsis
  system
  device
  device_init
  board
  slcommon
  emlib
  emdrv
  sleep_timer
  debug_swo
)

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
  COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${PROJECT_NAME}>
)

# Create the binary
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${PROJECT_NAME}> ${PROJECT_NAME}.bin
)

