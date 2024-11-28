# Typical usage: vivado -mode tcl -source run_bft_project.tcl
# Create the project and directory structure
create_project -force digilent_nexys ./ -part xc7a100tcsg324-1

# Get script directory
set script_dir [file dirname [file normalize [info script]]]
set project_dir [file normalize "${script_dir}/../"]
set src_dir [file normalize "${project_dir}/Src"]
set constr_dir [file normal "${project_dir}/constraints"]

# Add Source Files
add_files -fileset sources_1 {
  ./Src/top_level.vhd
}

# Add constraints
add_files -fileset constrs_1 ${constr_dir}/constraints.xdc

# Update to set top and file compile order
update_compile_order -fileset sources_1

# Launch Synthesis
launch_runs synth_1
wait_on_run synth_1
open_run synth_1 -name netlist_1

# Generate a timing and power reports and write to disk
# Can create custom reports as required
report_timing_summary -delay_type max -report_unconstrained -check_timing_verbose \
-max_paths 10 -input_pins -file syn_timing.rpt
report_power -file syn_power.rpt


# Launch Implementation
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# Generate a timing and power reports and write to disk
# comment out the open_run for batch mode
open_run impl_1
report_timing_summary -delay_type min_max -report_unconstrained \
-check_timing_verbose -max_paths 10 -input_pins -file imp_timing.rpt
report_power -file imp_power.rpt
