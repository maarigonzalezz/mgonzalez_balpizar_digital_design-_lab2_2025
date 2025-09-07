module ALU #(parameter n = 4)( 
				input logic [3:0] op,
				input logic [n-1: 0] num1, num2,
				output logic [n-1:0] result,
				output logic Z, N, V, C);
	// Resultados para cada operación
	logic [n-1:0] sum_result, rest_result, mult_result, div_result, mod_result;
	logic [n-1:0] and_result, or_result, xor_result, sleft_result, sright_result;
	
	
	// Instancia de Suma
	    nbit_adder #(
        .N(n)
    ) SUM_INST (
        .A   (num1),
        .B   (num2),
        .Cin (1'b0),
        .Sum (sum_result),
        .Cout(carry_sum)
    );
	
	
	// Instancia de Resta
		
	logic borrow_final;  // Borrow final de la resta

	nbit_subtractor #(.n(n)) u_nbit_sub(
		 .A(num1),          // Minuendo
		 .B(num2),          // Sustraendo
		 .D(rest_result),   // Resultado de la resta
		 .Bout(borrow_final) // Borrow final
	);
	
	
	// Instancia de Multiplicación
	
	
	
	// Operaciones division, modulo, and, or, xor, shift left y shift right
	
	assign div_result = num2 != 0 ? num1 / num2 : {n{1'b0}};
	assign mod_result = num2 != 0 ? num1 % num2 : {n{1'b0}};
	
	assign and_result = num1 & num2;
   assign or_result = num1 | num2;
   assign xor_result = num1 ^ num2;
   assign sleft_result = num1 << num2[$clog2(n)-1:0];  // Limitamos el shift a un valor según n
   assign sright_result = num1 >> num2[$clog2(n)-1:0];
	
	
	
	
	
endmodule

				