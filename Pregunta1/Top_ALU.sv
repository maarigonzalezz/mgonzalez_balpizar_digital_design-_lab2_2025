module Top_ALU (
				input logic [3:0] op,
				input logic [3: 0] num1, num2,
				output logic [3:0] result,
				output logic Z, N, V, C,
				output logic [6:0] seg);
				
	logic [3:0] opcode;

	assign opcode = ~op;
	
	// Instancia de la ALU
    ALU #(4) FPGA_ALU (
        .op(opcode),
        .num1(num1),
        .num2(num2),
        .result(result),
        .Z(Z),
        .N(N),
        .V(V),
        .C(C),
		  .seg(seg)
    );
		




endmodule
