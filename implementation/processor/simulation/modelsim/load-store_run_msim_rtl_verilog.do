transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/strassjm/Documents/CSSE232/rhit-csse232-2223b-project-violet-2223b-01/implementation/processor {C:/Users/strassjm/Documents/CSSE232/rhit-csse232-2223b-project-violet-2223b-01/implementation/processor/memory.v}

