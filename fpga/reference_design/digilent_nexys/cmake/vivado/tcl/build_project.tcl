# Initialize variables
set part_name ""
set top_name ""
set output_path "./"

set vhdl_sources {}
set verilog_sources {}
set constraint_sources {}
set ip_sources {}

# Loop through arguments
set i 0
while {$i < [llength $argv]} {
    set arg [lindex $argv $i]
    
    if {$arg eq "-vhdl_sources"} {
        incr i
        # Collect all paths after the flag
        while {$i < [llength $argv]} {
            set next_arg [lindex $argv $i]
            if {[string match -* $next_arg]} {break}  ;# Stop if next flag starts
            lappend vhdl_sources $next_arg
            incr i
        }
        incr i -1  ;# Adjust index since inner loop already incremented
    }
    
    if {$arg eq "-verilog_sources"} {
        incr i
        # Collect all paths after the flag
        while {$i < [llength $argv]} {
            set next_arg [lindex $argv $i]
            if {[string match -* $next_arg]} {break}  ;# Stop if next flag starts
            lappend verilog_sources $next_arg
            incr i
        }
        incr i -1  ;# Adjust index since inner loop already incremented
    }
    
    if {$arg eq "-constraint_sources"} {
        incr i
        # Collect all paths after the flag
        while {$i < [llength $argv]} {
            set next_arg [lindex $argv $i]
            if {[string match -* $next_arg]} {break}  ;# Stop if next flag starts
            lappend constraint_sources $next_arg
            incr i
        }
        incr i -1  ;# Adjust index since inner loop already incremented
    }
    
    if {$arg eq "-ip_sources"} {
        incr i
        # Collect all paths after the flag
        while {$i < [llength $argv]} {
            set next_arg [lindex $argv $i]
            if {[string match -* $next_arg]} {break}  ;# Stop if next flag starts
            lappend ip_sources $next_arg
            incr i
        }
        incr i -1  ;# Adjust index since inner loop already incremented
    }
    
    if {$arg eq "-part_name"} {
        incr i
        set part_name [lindex $argv $i]
        incr - -1;
    }
    
    if {$arg eq "-top_name"} {
        incr i
        set top_name [lindex $argv $i]
        incr - -1;
    }
    
    if {$arg eq "-output_bitstream"} {
        incr i
        set output_bitstream [lindex $argv $i]
        incr - -1;
    }
    
    if {$arg eq "-output_path"} {
        incr i
        set output_path [lindex $argv $i]
        incr - -1;
    }
    
    incr i
}

# Create project in memory
create_project -in_memory -part ${part_name}

# Add Sources
add_files $vhdl_sources $constraint_sources $ip_sources

# Synthesize
synth_design -top $top_name -part $part_name
write_checkpoint -force post_synth
report_timing_summary -file post_synth_timing_summary.rpt
report_power -file post_synth_power.rpt

# Place
opt_design
power_opt_design
place_design
phys_opt_design
write_checkpoint -force post_place
report_timing_summary -file post_place_timing_summary.rpt

# Route
route_design
write_checkpoint -force post_route
report_timing_summary -file post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file post_route_timing.rpt
report_clock_utilization -file chock_util.rpt
report_power -file post_route_power.rpt
report_drc -file post_imp_drc.rpt
write_verilog -force impl_netlist.v
write_xdc -no_fixed_only -force prj_impl.xdc

# Generate Bitstream
write_bitstream -force "$output_path/output_bitstream.bit"