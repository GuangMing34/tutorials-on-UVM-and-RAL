#
# modelsim.mk
#

# user definable variables

MODELSIM_LIB_DIR  := ./work
MODELSIM_LIB_NAME := work

# constants


modelsim_compile_files := $(compile_files) 
modelsim_compile_opts  := $(compile_opts) +define+CL_USE_MODELSIM -ccflags "-DQUESTA"
modelsim_run_opts      := $(run_opts)
modelsim_run_cmd_file  := modelsim.cmd

# targets

modelsim: prep_modelsim run_modelsim

prep_modelsim:
	echo ## >run.do
	echo if [file exists "work"] {vdel -all} >> run.do
	echo vlib $(MODELSIM_LIB_DIR) >> run.do
	echo vmap $(MODELSIM_LIB_NAME) $(MODELSIM_LIB_DIR) >> run.do

run_modelsim:
	echo vlog $(modelsim_compile_opts) $(modelsim_compile_files) >> run.do
	echo vopt top -o top_optimized +acc >> run.do
	echo vsim top_optimized $(modelsim_run_opts) -do modelsim.cmd >> run.do
	vsim -c -do run.do

clean_modelsim:
	vdel -lib $(MODELSIM_LIB_NAME) -all
