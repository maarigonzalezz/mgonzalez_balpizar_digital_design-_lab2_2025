module ALU #(parameter n = 4)( 
				input logic [3:0] op,
				input logic [n-1: 0] num1, num2,
				output logic [n-1:0] result,
				output logic Z, N, V, C,
				output logic [6:0] seg);
	// Resultados para cada operación
	logic [2*n-1:0] mult_result;
	logic [n-1:0] sum_result, rest_result, div_result, mod_result;
	logic [n-1:0] and_result, or_result, xor_result, sleft_result, sright_result;
	logic V_resta;
	
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
		 .Bout(borrow_final), // Borrow final
		 .V(V_resta)
	);
	
	
	// Instancia de Multiplicación
	
	nbit_multiplier #(
		 .N(n)                   // Tamaño de los operandos
	) MULT_INST (
		 .A(num1),               // Multiplicando
		 .B(num2),               // Multiplicador
		 .Product(mult_result)   // Resultado de la multiplicación
	);
	
	
	// Operaciones division, modulo, and, or, xor, shift left y shift right
	
	assign div_result = num2 != 0 ? num1 / num2 : {n{1'b0}};
	assign mod_result = num2 != 0 ? num1 % num2 : {n{1'b0}};
	
	assign and_result = num1 & num2;
   assign or_result = num1 | num2;
   assign xor_result = num1 ^ num2;
   assign sleft_result = num1 << num2[$clog2(n)-1:0];  // Limitamos el shift a un valor según n
   assign sright_result = num1 >> num2[$clog2(n)-1:0];
	
	
	// Selección de resultado según op
    always_comb begin
        case(op)
            4'b0000: result = sum_result;       		// Suma
            4'b0001: result = rest_result;      		// Resta
            4'b0010: result = and_result;       		// AND
            4'b0011: result = or_result;        		// OR
            4'b0100: result = xor_result;       		// XOR
            4'b0101: result = sleft_result;     		// Shift left
            4'b0110: result = sright_result;    		// Shift right
            4'b0111: result = mult_result[n-1:0];   	// Multiplicación (truncada a n bits)
            4'b1000: result = div_result;					// Division
            4'b1001: result = mod_result;       		// Módulo
            default: result = {n{1'b0}};
        endcase
    end
	
	// Instancia del 7 segmentos
	BinTo7Seg display_unidades (
			.bin(result), 
			.seg(seg));
	 
    // ---------------------- Flags ----------------------
	 assign V = (op == 4'b0001) & (num1 - num2 < -8);
	 
    always_comb begin
        // Zero flag
        Z = (result == 0);

        // Negative flag (solo en resta)
        if (op == 4'b0001)
            N = result[n-1];
        else
            N = 0;

        // Carry flag
        case(op)
				// SUMA
				// El carry es el Cout del ultimo bit
            4'b0000: C = carry_sum;
				// RESTA
				// Se toma como carry el borrow final
            4'b0001: C = borrow_final; 
				// SHIFT LEFT
				// Se toma como carry el bit perdido 
            4'b0101: C = num1[n-1];
				// SHIFT RIGHT
				// Se toma como carry el bit perdido 
            4'b0110: C = num1[0];
				// MULTIPLICACIÓN (truncamiento)
				// Se trunca el numero a N bits del resultado, si alguno de sus bits es 1
				// Siginifca que la multiplicacion excedio los N bits y hubo carry
            4'b0111: C = |mult_result[2*n-1:n];
				// DIVISIÓN
				// Se toma como catty el residuo
            4'b1000: C = (num2 != 0) ? (num1 % num2 != 0) : 0;
				// AND, OR, XOR, MÓDULO
				// No hay carry
            default: C = 0;                                
        endcase
    end
	 
	 
	
endmodule

				