function(vivado_build_project PART_NAME TOP_LEVEL)
    set(VERILOG_SOURCES )
    set(SYSTEM_VERILOG_SOURCES)
    set(VHDL_SOURCES)
    set(CONSTRAINT_SOURCES)
    set(OUTPUT_PATH)
    set(OUTPUT_BITSTREAM)
    
    set(current_key "")
    
    set(options 
        "VERILOG_SOURCES"
        "SYSTEM_VERILOG_SOURCES"
        "VHDL_SOURCES"
        "IP_SOURCES"
        "CONSTRAINT_SOURCES"
        "OUTPUT_PATH"
        "OUTPUT_BITSTREAM"
    )
    
    foreach(arg IN LISTS ARGN)
        if (arg IN_LIST options)
            set(current_key ${arg})
        elseif (${current_key} IN_LIST options)
            set(${current_key} ${arg})
        else()
            message("Invalid argument name ${arg}")
        endif()
    endforeach()
        
    if (NOT DEFINED OUTPUT_PATH)
        set(OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bitstream)
    endif()
    
    if (NOT DEFINED OUTPUT_BITSTREAM)
        set(OUTPUT_BITSTREAM "output.bit")
    endif()
    
    add_custom_target(${OUTPUT_BITSTREAM}
        COMMAND bash -c "vivado -mode batch -source ${CMAKE_CURRENT_LIST_DIR}/cmake/vivado/tcl/build_project.tcl -tclargs -part_name ${PART_NAME} -top_name ${TOP_LEVEL} -output_bitstream ${OUTPUT_BITSTREAM} -vhdl_sources ${VHDL_SOURCES} -verilog_sources ${VERILOG_SOURCES} -constraint_sources ${CONSTRAINT_SOURCES} -ip_sources ${IP_SOURCES}"
        VERBATIM
    )
    
    
endfunction()