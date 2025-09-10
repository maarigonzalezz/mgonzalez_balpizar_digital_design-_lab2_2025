// ---------------------- 1-bit Subtractor ----------------------
module bit_subtractor(
    input  logic A,      // Bit del minuendo
    input  logic B,      // Bit del sustraendo
    input  logic Bin,    // Borrow in (préstamo de etapa anterior)
    output logic D,      // Diferencia
    output logic Bout    // Borrow out (préstamo a siguiente etapa)
);

    assign D    = A ^ B ^ Bin;           // Diferencia
    assign Bout = (~A & B) | (Bin & ~(A ^ B));  // Préstamo de salida

endmodule