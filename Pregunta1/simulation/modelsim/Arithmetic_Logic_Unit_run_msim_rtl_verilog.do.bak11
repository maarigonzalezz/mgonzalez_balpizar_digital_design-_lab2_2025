transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/BinTo7Seg.sv}
vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/ALU.sv}
vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/nbit_adder.sv}
vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/nbit_substractor.sv}
vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/1bit_subtractor.sv}
vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/full_adder_1bit.sv}
vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/1bit_multiplier.sv}
vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/nbit_multiplier.sv}

vlog -sv -work work +incdir+C:/Users/gonza/Desktop/lab2\ taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1 {C:/Users/gonza/Desktop/lab2 taller/mgonzalez_balpizar_digital_design-_lab2_2025/Pregunta1/ALU_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ALU_tb

add wave *
view structure
view signals
run -all
