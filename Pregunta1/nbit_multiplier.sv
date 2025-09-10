// ---------------------- Multiplicador N×N bits usando bit_multiplier ----------------------
module nbit_multiplier #(
    parameter N = 4
)(
    input  logic [N-1:0] A,
    input  logic [N-1:0] B,
    output logic [2*N-1:0] Product
);

    // Productos parciales
    logic [N-1:0][N-1:0] pp;
    // Carries internos, inicializados a 0 automáticamente
    logic [N:0][N-1:0] carry_matrix;

    genvar i, j;

    // Generación de productos parciales
    generate
        for (i = 0; i < N; i = i + 1) begin : ROWS
            for (j = 0; j < N; j = j + 1) begin : COLS
                logic P_bit, Cout_bit;

                bit_multiplier u_bit_mul (
                    .A(A[j]),
                    .B(B[i]),
                    .Cin(carry_matrix[i][j]),
                    .P(P_bit),
                    .Cout(Cout_bit)
                );

                assign pp[i][j] = P_bit;

                // Propagación de carry dentro del generate
                if (j < N-1)
                    assign carry_matrix[i][j+1] = Cout_bit;
            end
        end
    endgenerate

    // Suma final de los productos parciales
    integer k;
    always_comb begin
        Product = 0;
        for (k = 0; k < N; k = k + 1)
            Product = Product + ({{N{1'b0}}, pp[k]} << k);
    end

endmodule