// ---------------------- Sumador de N bits usando full adders ----------------------
module nbit_adder #(
    parameter N = 4   // Número de bits
)(
    input  logic [N-1:0] A, B,   // Entradas
    input  logic Cin,            // Acarreo de entrada
    output logic [N-1:0] Sum,    // Resultado de la suma
    output logic Cout            // Acarreo de salida
);

    // Señales internas de acarreo
    logic [N:0] carry;
    assign carry[0] = Cin; // Conectar Cin al primer FA

    // Instanciación estructural: N full adders en cascada
    genvar i;
    generate
        for (i = 0; i < N; i++) begin : adder_loop
            full_adder FA_inst (
                .A   (A[i]),
                .B   (B[i]),
                .Cin (carry[i]),
                .Sum (Sum[i]),
                .Cout(carry[i+1])
            );
        end
    endgenerate

    // Carry final
    assign Cout = carry[N];

endmodule