
# build settings
set design_name "digilent_nexys_reference"
set arch "xc7"
set board_name "Nexys 4 DDR"
set fpga_part "xc7a100tcsg324-1"

# set reference directories for source files
set script_dir [file normalize [info script]]
set project_dir [file normalize "${script_dir}/../../"]
set project_src_dir [file normalize "${project_dir}/Src"]
set project_constraints_dir [file normalize "${project_dir}/constraints"]

# read design sources
read_vhdl "${project_src_dir}/top_level.vhd"

# read constraints
read_xdc "${project_constraints_dir}/constraints.xdc"

# synth
synth_design -top "top_level" -part ${fpga_part}

# place and route
opt_design
place_design
route_design

# write bitstream
write_bitstream -force "${project_dir}/build/${design_name}.bit"