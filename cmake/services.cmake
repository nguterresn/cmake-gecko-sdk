if(NOT DEFINED PROJ_PATH)
  message(FATAL_ERROR "Please include the `PROJ_PATH`")
endif()

if (DEFINED DEBUG)
  message("Adding 'device_init.a', 'system.a', 'sleep_timer.a', 'iostream.a' and 'udelay.a'.")
endif()

# DEVICE INIT
add_library(device_init
  ${PROJ_PATH}/gecko_sdk/platform/service/device_init/src/sl_device_init_nvic.c
  ${PROJ_PATH}/gecko_sdk/platform/service/device_init/src/sl_device_init_dcdc_s2.c
  ${PROJ_PATH}/gecko_sdk/platform/service/device_init/src/sl_device_init_lfxo_s2.c
  ${PROJ_PATH}/gecko_sdk/platform/service/device_init/src/sl_device_init_hfxo_s2.c
  ${PROJ_PATH}/gecko_sdk/platform/service/device_init/src/sl_device_init_emu_s2.c
)
target_include_directories(device_init PUBLIC
  ${PROJ_PATH}/gecko_sdk/platform/service/device_init/inc
  ${PROJ_PATH}/config
)
target_link_libraries(device_init slcommon emlib)

# SYSTEM
add_library(system
  ${PROJ_PATH}/gecko_sdk/platform/service/system/src/sl_system_init.c
  ${PROJ_PATH}/gecko_sdk/platform/service/system/src/sl_system_process_action.c
)
target_include_directories(system PUBLIC ${PROJ_PATH}/gecko_sdk/platform/service/system/inc)
target_link_libraries(system device)

# SLEEP TIMER
add_library(sleep_timer
  ${PROJ_PATH}/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer.c
  ${PROJ_PATH}/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.c
  ${PROJ_PATH}/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_burtc.c
  ${PROJ_PATH}/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtc.c
  ${PROJ_PATH}/gecko_sdk/platform/service/sleeptimer/src/sl_sleeptimer_hal_rtcc.c
)
target_include_directories(sleep_timer PUBLIC
  ${PROJ_PATH}/gecko_sdk/platform/service/sleeptimer/inc
  ${PROJ_PATH}/gecko_sdk/platform/service/sleeptimer/src
  ${PROJ_PATH}/config
)
target_link_libraries(sleep_timer slcommon device emlib)

# IOSTREAM
add_library(iostream ${PROJ_PATH}/gecko_sdk/platform/service/iostream/src/sl_iostream.c)
target_include_directories(iostream PUBLIC ${PROJ_PATH}/gecko_sdk/platform/service/iostream/inc)
target_link_libraries(iostream device slcommon emlib)

# UDELAY
add_library(udelay
  ${PROJ_PATH}/gecko_sdk/platform/service/udelay/src/sl_udelay.c
  ${PROJ_PATH}/gecko_sdk/platform/service/udelay/src/sl_udelay_armv6m_gcc.S
)
target_include_directories(udelay PUBLIC ${PROJ_PATH}/gecko_sdk/platform/service/udelay/inc)
target_link_libraries(udelay emlib)
