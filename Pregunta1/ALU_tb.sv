`timescale 1ns/1ps
module ALU_tb;

    parameter n = 4;

    // Señales de entrada
    logic [3:0] op;
    logic [n-1:0] num1, num2;

    // Señales de salida
    logic [n-1:0] result;
    logic Z, N, V, C;
	 logic [6:0] seg;
	 
	 // Declarar señales esperadas para la comprobación
    logic [3:0] expected_result;             // Cambiado a 4 bits
    logic expected_N, expected_Z, expected_C, expected_V;

    // Instancia de la ALU
    ALU #(4) uut (
        .op(op),
        .num1(num1),
        .num2(num2),
        .result(result),
        .Z(Z),
        .N(N),
        .V(V),
        .C(C),
		  .seg(seg)
    );

    // Generador de reloj simple
    logic clk;
    initial clk = 0;
    always #5 clk = ~clk; // ciclo de 10ns
	 
	  task display_7seg(input [6:0] seg);
        begin
            case (seg)
                7'b1000000: $write("0");
                7'b1111001: $write("1");
                7'b0100100: $write("2");
                7'b0110000: $write("3");
                7'b0011001: $write("4");
                7'b0010010: $write("5");
                7'b0000010: $write("6");
                7'b1111000: $write("7");
                7'b0000000: $write("8");
                7'b0010000: $write("9");
					 7'b0001000: $write("A");
					 7'b0000011: $write("B"); 
                7'b1000110: $write("C"); 
                7'b0100001: $write("D");
                7'b0000110: $write("E"); 
                7'b0001110: $write("F"); 
                default:    $write("X");
            endcase
            $write("\n");
        end
    endtask
	 
	 // Tarea para verificar el resultado
    task check_result;
        if (result !== expected_result) $display("Error: resultado incorrecto Esperado %b, obtenido %b", expected_result, result);
        if (N !== expected_N) $display("Error: bandera N incorrecta: Esperado %b, obtenido %b", expected_N, N);
        if (Z !== expected_Z) $display("Error: bandera Z incorrecta: Esperado %b, obtenido %b", expected_Z, Z);
        if (C !== expected_C) $display("Error: bandera C incorrecta: Esperado %b, obtenido %b", expected_C, C);
        if (V !== expected_V) $display("Error: bandera V incorrecta: Esperado %b, obtenido %b", expected_V, V);
    endtask

    // Proceso secuencial de pruebas con desfases
    initial begin
	 
	 
	 
	 // -------------------------- Prueba de suma ------------------------------
	 $display("---------------SUMA---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
    num1 = 4'b0011; num2 = 4'b0010; op = 4'b0000;
    expected_result = 4'b0101;
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();
	 
    num1 = 4'b1100; num2 = 4'b0100; op = 4'b0000;
    expected_result = 4'b0000;  // Resultado 0 con acarreo
    expected_N = 0; expected_Z = 1; expected_C = 1; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

    // --------------------------- Prueba de resta ------------------------------
	 $display("---------------RESTA---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
    num1 = 4'b0111; num2 = 4'b0011; op = 4'b0001;
    expected_result = 4'b0100;
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

	 num1 = 4'b0010; num2 = 4'b0100; op = 4'b0001;
    expected_result = 4'b1110;  // Resultado negativo
    expected_N = 1; expected_Z = 0; expected_C = 1; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();
	 
	 num1 = 4'b0001; num2 = 4'b1111; op = 4'b0001;
    expected_result = 4'b0010;  // Resultado negativo
    expected_N = 1; expected_Z = 0; expected_C = 1; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();
	 
	 // ---------------------------- Prueba de AND -------------------------------
	 $display("---------------AND---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
	 num1 = 4'b1111; num2 = 4'b1110; op = 4'b0010;
    expected_result = 4'b1110;
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

	 num1 = 4'b1010; num2 = 4'b0101; op = 4'b0010;
    expected_result = 4'b0000;
    expected_N = 0; expected_Z = 1; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

    // ---------------------------- Prueba de OR --------------------------------
	 $display("---------------OR---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
	 num1 = 4'b1111; num2 = 4'b0000; op = 4'b0011;
    expected_result = 4'b1111;
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

	 num1 = 4'b0001; num2 = 4'b0010; op = 4'b0011;
    expected_result = 4'b0011;
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

    // ---------------------------- Prueba de XOR -------------------------------
	 $display("---------------XOR---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
    num1 = 4'b1100; num2 = 4'b0011; op = 4'b0100;
    expected_result = 4'b1111;
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

	 num1 = 4'b1010; num2 = 4'b1010; op = 4'b0100;
    expected_result = 4'b0000;  // XOR idéntico
    expected_N = 0; expected_Z = 1; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

    // ---------------------------- Prueba de shift left ------------------------
	 $display("---------------SHIFT LEFT---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
	 num1 = 4'b0001; num2 = 4'b0010; op = 4'b0101;
    expected_result = 4'b0100;
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

	 num1 = 4'b1000; num2 = 4'b0001; op = 4'b0101;
    expected_result = 4'b0000;  // Desplazamiento que genera un 0
    expected_N = 0; expected_Z = 1; expected_C = 1; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

    // ---------------------------- Prueba de shift right -----------------------
	 $display("---------------SHIFT RIGHT---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
	 num1 = 4'b1000; num2 = 4'b0010; op = 4'b0110;
    expected_result = 4'b0010;
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

	 num1 = 4'b1010; num2 = 4'b0001; op = 4'b0110;
    expected_result = 4'b0101;  // Desplazamiento a la derecha
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();


    // ---------------------------- Prueba de multiplicación --------------------
	 $display("---------------MULTIPLICACION---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
    num1 = 4'b1111; num2 = 4'b1111; op = 4'b0111;
    expected_result = 4'b0001;
    expected_N = 0; expected_Z = 0; expected_C = 1; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();

   
	 num1 = 4'b0110; num2 = 4'b0010; op = 4'b0111;
    expected_result = 4'b1100;  // Multiplicación de 6 y 2
    expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
    #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
    check_result();
	 
	 // ---------------------------- Prueba de división --------------------
	 $display("---------------DIVISION---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
	 num1 = 4'b0110; num2 = 4'b0010; op = 4'b1000;  
	 expected_result = 4'b0011;  // 6 / 2 = 3
	 expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
	 #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
	 check_result();

	 num1 = 4'b1000; num2 = 4'b0011; op = 4'b1000; 
	 expected_result = 4'b0010;
	 expected_N = 0; expected_Z = 0; expected_C = 1; expected_V = 0;
	 #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
	 check_result();


	 // ---------------------------- Prueba de módulo --------------------
	 $display("---------------MODULO---------------");
	 $display("Tiempo\tOP\tNum1\tNum2\tResult\tZ N V C");
	 
	 num1 = 4'b1001; num2 = 4'b0011; op = 4'b1001; 
	 expected_result = 4'b0000;  // 9 % 3 = 0
	 expected_N = 0; expected_Z = 1; expected_C = 0; expected_V = 0;
	 #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
	 check_result();


	 num1 = 4'b1010; num2 = 4'b0011; op = 4'b1001; 
	 expected_result = 4'b0001;  // 10 % 3 = 1
	 expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
	 #10;
	 $display("%0t\t%b\t%d\t%d\t%d\t%b %b %b %b", $time, op, num1, num2, result, Z, N, V, C);	
	 display_7seg(seg);
	 check_result();

    
    // Finalizar simulación
    $stop;
	 
	end

    

endmodule