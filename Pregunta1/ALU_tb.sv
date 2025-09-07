`timescale 1ns/1ps
module tb_ALU;

    parameter n = 4;

    // Señales de entrada
    logic [3:0] op;
    logic [n-1:0] num1, num2;

    // Señales de salida
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

    // Generador de reloj simple
    logic clk;
    initial clk = 0;
    always #5 clk = ~clk; // ciclo de 10ns

    // Proceso secuencial de pruebas con desfases
    initial begin
        // Inicialización
        op = 4'b0000; num1 = 0; num2 = 0;
        #10;

        $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");

        // ------------------- Suma -------------------
        op = 4'b0000; num1 = 4'd3; num2 = 4'd5; #10;
        $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        op = 4'b0000; num1 = 4'd7; num2 = 4'd8; #10;
        $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- Resta -------------------
        op = 4'b0001; num1 = 4'd10; num2 = 4'd4; #10;
        $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        op = 4'b0001; num1 = 4'd3; num2 = 4'd7; #10;
        $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- AND -------------------
        op = 4'b0010; num1 = 4'b1010; num2 = 4'b1100; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- OR -------------------
        op = 4'b0011; num1 = 4'b1010; num2 = 4'b1100; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- XOR -------------------
        op = 4'b0100; num1 = 4'b1010; num2 = 4'b1100; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- Shift left -------------------
        op = 4'b0101; num1 = 4'b0011; num2 = 4'b0010; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- Shift right -------------------
        op = 4'b0110; num1 = 4'b1100; num2 = 4'b0010; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- Multiplicación -------------------
        op = 4'b0111; num1 = 4'd3; num2 = 4'd4; #10;
        $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- División -------------------
        op = 4'b1000; num1 = 4'd12; num2 = 4'd3; #10;
        $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        // ------------------- Módulo -------------------
        op = 4'b1001; num1 = 4'd13; num2 = 4'd5; #10;
        $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);

        $stop;
    end

endmodule