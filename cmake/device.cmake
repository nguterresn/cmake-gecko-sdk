if(NOT DEFINED PROJ_PATH)
  message(FATAL_ERROR "Please include the `PROJ_PATH`")
endif()
if(NOT DEFINED DEVICE)
  message(FATAL_ERROR "Please include the `DEVICE`")
endif()

# Include the linker file
set(bluetooth_module_ld_file            ${PROJ_PATH}/autogen/linkerfile.ld)

set(CPU_ARCH
  -mcpu=cortex-m33
  -mcmse
  -mfpu=fpv5-sp-d16
  -mfloat-abi=hard
)

set(COMMON_DEFINITIONS
  -std=c99
  -mthumb
  -Os
  -Wall
  -Wextra
  -g3
  -O0
  ${CPU_ARCH}
)

set(DEPFLAGS
  -c
  -fmessage-length=0
  -MMD
  -MP
)

set(BLUETOOTH_MODULE_LINKER_OPTIONS
  ${CPU_ARCH}
  -Xlinker
  -T${bluetooth_module_ld_file}
  -specs=nosys.specs
  -Wl,--start-group
  -lc
  -lm
  -Wl,--end-group
  -Wl,--print-memory-usage
)

if (DEFINED DEBUG)
  message("Adding 'device.a'.")
  message("Linker flags: " ${BLUETOOTH_MODULE_LINKER_OPTIONS})
endif()

# Compiler options
set(BLUETOOTH_MODULE_CFLAGS ${COMMON_DEFINITIONS} ${DEPFLAGS})

set(device_INCLUDE
  ${PROJ_PATH}/autogen
  ${PROJ_PATH}/gecko_sdk/platform/Device/SiliconLabs/BGM22/Include
)

file(GLOB device_SRC CONFIGURE_DEPENDS
  ${PROJ_PATH}/gecko_sdk/platform/Device/SiliconLabs/BGM22/Source/GCC/startup_bgm22.s
  ${PROJ_PATH}/gecko_sdk/platform/Device/SiliconLabs/BGM22/Source/*.c
)

add_library(device ${device_SRC})
target_include_directories(device PUBLIC ${device_INCLUDE})
# Add necessary flags
target_compile_options(device PUBLIC ${BLUETOOTH_MODULE_CFLAGS})
target_link_options(device PUBLIC ${BLUETOOTH_MODULE_LINKER_OPTIONS})

target_compile_definitions(device PUBLIC
  -${DEVICE}=1
  -DHARDWARE_BOARD_DEFAULT_RF_BAND_2400=1
  -DHARDWARE_BOARD_SUPPORTS_1_RF_BAND=1
  -DHARDWARE_BOARD_SUPPORTS_RF_BAND_2400=1
  -DSL_COMPONENT_CATALOG_PRESENT=1
)

target_link_libraries(device cmsis)
