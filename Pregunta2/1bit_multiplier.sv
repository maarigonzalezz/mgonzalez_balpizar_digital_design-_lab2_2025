// Modulo multiplicador de un bit
module bit_multiplier (
    input  logic A,
    input  logic B,
    input  logic Cin,   // Carry de entrada
    output logic P,     // Producto
    output logic Cout   // Carry de salida
);

    // Producto de 1 bit (AND)
    assign P = A & B;

    // Carry según Propuesta 1
    assign Cout = P & Cin;

endmodule