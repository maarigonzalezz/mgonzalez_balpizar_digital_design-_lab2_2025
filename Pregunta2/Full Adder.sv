// ---------------------- Full Adder de 1 bit ----------------------
module full_adder (
    input  logic A,       // Entrada A
    input  logic B,       // Entrada B
    input  logic Cin,     // Acarreo de entrada
    output logic Sum,     // Suma
    output logic Cout     // Acarreo de salida
);

    // Resultado de la suma
    assign Sum  = A ^ B ^ Cin;  
	 // Acarreo de Salida (Entrada del siguiente para n-bits)
    assign Cout = (A & B) | (Cin & (A ^ B)); 

endmodule