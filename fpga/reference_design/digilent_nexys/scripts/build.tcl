
# Define directories
set script_dir [file dirname [file normalize [info script]]]
set project_dir [file normalize "${script_dir}/../"]
set src_dir [file normalize "${project_dir}/Src"]
set constr_dir [file normal "${project_dir}/constraints"]

set design_name "digilent_nexys_reference"
set arch "xc7"
set board_name "Nexys 4 DDR"
set fpga_part "xc7a100tcsg324-1"

# read design sources
read_vhdl "${src_dir}/top_level.vhd"

# read constraints
read_xdc "${constr_dir}/constraints.xdc"

# synth
synth_design -top "top_level" -part ${fpga_part}

# place and route
opt_design
place_design
route_design

# write bitstream
file mkdir ${project_dir}/build
write_bitstream -force "${project_dir}/build/${design_name}.bit"