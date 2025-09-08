module register #(
    parameter n = 4    // Tamaño del registro
)(
    input logic clk,       // Reloj del sistema
    input logic reset,     // Reset del sistema
    input logic [n-1:0] d, // Entrada de datos
    output logic [n-1:0] q  // Salida de datos
);

    // Registro sincronizado con el reloj
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            q <= {n{1'b0}};  // Limpiar el registro en caso de reset
        else
            q <= d;              // Capturar la entrada en el flanco positivo del reloj
    end

endmodule
