// ---------------------- Testbench para ALU ----------------------
`timescale 1ns/1ps

module tb_ALU;

    parameter n = 4;

    // Entradas
    logic [3:0] op;
    logic [n-1:0] num1, num2;

    // Salidas
    logic [n-1:0] result;
    logic Z, N, V, C;

    // Instancia de la ALU
    ALU #(.n(n)) uut (
        .op(op),
        .num1(num1),
        .num2(num2),
        .result(result),
        .Z(Z),
        .N(N),
        .V(V),
        .C(C)
    );

    initial begin
        // Inicialización
        $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");

        // ------------------- Prueba de Suma -------------------
        op = 4'b0000; num1 = 4'd3; num2 = 4'd5; #10;
        $display("%0t\t%0b\t%0d\t%0d\t%0d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        op = 4'b0000; num1 = 4'd7; num2 = 4'd8; #10;
        $display("%0t\t%0b\t%0d\t%0d\t%0d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- Prueba de Resta -------------------
        op = 4'b0001; num1 = 4'd10; num2 = 4'd4; #10;
        $display("%0t\t%0b\t%0d\t%0d\t%0d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        op = 4'b0001; num1 = 4'd3; num2 = 4'd7; #10;
        $display("%0t\t%0b\t%0d\t%0d\t%0d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // Fin de la simulación
        $stop;
    end

endmodule