#!/bin/bash
set -e

# Define directories
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

VIVADO_DIR="${VIVADO_DIR:=/tools/Xilinx/Vivado/2024.2}"

if [ ! -f ${VIVADO_DIR}/settings64.sh ]; then
    echo "Please provide a path to your Vivado install directory by setting VIVADO_DIR"
    echo "    Example: export VIVADO_DIR=/tools/Xilinx/Vivado/2024.2"
    exit 1
fi

# Setup Environment
source ${VIVADO_DIR}/settings64.sh

# Run build
vivado -mode batch -nolog -nojournal -source ${SCRIPT_DIR}/build.tcl
