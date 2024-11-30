cmake_minimum_required(VERSION 3.20)

project(digilent_nexys)

include(cmake/vivado/vivado_functions.cmake)

set(PART_NAME "XC7A100TCSG324-1")
set(VIVADO_PATH_DIR "/tools/Xilinx/Vivado")

set(VHDL_SOURCES
    ${CMAKE_SOURCE_DIR}/Src/top_level.vhd
)

set(CONSTRAINT_SOURCES
    ${CMAKE_SOURCE_DIR}/constraints/constraints.xdc
)

set(IP_SOURCES
    ${CMAKE_SOURCE_DIR}/IP/vga_ila/vga_ila.xci
)

vivado_build_project(
    ${PART_NAME}
    "top_level"
    VHDL_SOURCES ${VHDL_SOURCES}
    CONSTRAINT_SOURCES ${CONSTRAINT_SOURCES}
    OUTPUT_BITSTREAM ${CMAKE_PROJECT_NAME}.bit
    IP_SOURCES ${IP_SOURCES}
)



