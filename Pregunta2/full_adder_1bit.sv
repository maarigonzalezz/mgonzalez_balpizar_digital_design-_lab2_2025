// ---------------------- Full Adder de 1 bit ----------------------
module full_adder_1bit(
    input  logic A,     // Primer operando de 1 bit
    input  logic B,     // Segundo operando de 1 bit
    input  logic Cin,   // Acarreo de entrada desde la etapa anterior
    output logic Sum,   // Bit de suma resultante
    output logic Cout   // Acarreo de salida hacia la siguiente etapa
);

    // Suma: XOR de A, B y Cin
    assign Sum  = A ^ B ^ Cin;
    
    // Carry de salida (Entrada del siguiente)
    assign Cout = (A & B) | (Cin & (A ^ B));

endmodule