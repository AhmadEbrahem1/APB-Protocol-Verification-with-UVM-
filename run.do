
# Compile the design and testbench
vlog -f rtl.f  -f tb.f  -lint -cover bcesfx



set tests {APB_basic_test }

# Run simulations with different test defines
foreach test $tests {
    set logfile "$test.log"
    vsim +timescale+1ns/1ns  -voptargs=+acc -wlf $test.wlf  testbench \
        +UVM_TESTNAME=$test \
        +UVM_VERBOSITY=UVM_LOW \
        -sv_seed random -coverage -c -assertdebug \
        -l $logfile  \
		 -do "log -r /*"

	set NoQuitOnFinish 1
    run -all
    coverage save $test.ucdb
 
}


#To convert the .vcd to a .wlf, type the following at the command-line:
#vcd2wlf <example>.vcd <example>.wlf


# Merge coverage results
vcover merge -out coverage_merged.ucdb *.ucdb

# Generate coverage reports
vcover report coverage_merged.ucdb -details  -output coverage_report.txt
#vcover report coverage_merged.ucdb -details -html -output coverage_html
#or
vcover report coverage_merged.ucdb -details -html 

#to open gui and exckude
#vcover gui coverage_merged.ucdb



