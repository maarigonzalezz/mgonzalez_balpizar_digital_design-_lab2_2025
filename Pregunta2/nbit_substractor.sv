// ---------------------- N-bit Subtractor ----------------------
module nbit_subtractor #(parameter n = 4)(
    input  logic [n-1:0] A,       // Minuendo
    input  logic [n-1:0] B,       // Sustraendo
    output logic [n-1:0] D,       // Resultado de la resta
    output logic Bout,             // Préstamo final
	 output logic V
);

    logic [n:0] borrow;           // Cadena de préstamos
    assign borrow[0] = 1'b0;      // Borrow inicial = 0

    genvar i;
    generate
        for (i = 0; i < n; i = i + 1) begin : SUB_BITS
            bit_subtractor u_bit_sub(
                .A(A[i]),
                .B(B[i]),
                .Bin(borrow[i]),
                .D(D[i]),
                .Bout(borrow[i+1])
            );
        end
    endgenerate

    assign Bout = borrow[n];       // Borrow final
	 
	 // Overflow
    assign V = (A[n-1] ^ B[n-1]) & (A[n-1] ^ D[n-1]);
	 
endmodule