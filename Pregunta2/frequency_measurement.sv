module frequency_measurement #(
    parameter n = 2  // Ancho de los operandos y resultados
)(
    input logic clk,                // Reloj del sistema
    input logic reset,              // Reset del sistema
    input logic [n-1:0] a, b,   // Entradas para la ALU
    input logic [3:0] opcode,       // Código de operación para la ALU
    output logic [n-1:0] result,// Resultado de la ALU
    output logic N, Z, C, V         // Banderas de la ALU
);

    // Señales internas
    logic [n-1:0] reg_a, reg_b;
    logic [n-1:0] alu_result;
    logic alu_N, alu_Z, alu_C, alu_V;

    // Instancia del registro de entrada
    register #(.n(n)) reg_a_inst (
        .clk(clk),
        .reset(reset),
        .d(a),
        .q(reg_a)
    );

    register #(.n(n)) reg_b_inst (
        .clk(clk),
        .reset(reset),
        .d(b),
        .q(reg_b)
    );

    // Instancia del módulo ALU
    ALU #(
        .n(n)
    ) alu_instance (
        .num1(reg_a),
        .num2(reg_b),
        .op(opcode),
        .result(alu_result),
        .N(alu_N),
        .Z(alu_Z),
        .C(alu_C),
        .V(alu_V)
    );

    // Instancia del registro de salida
    register #(.n(n)) reg_out_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_result),
        .q(result)
    );

    // Instancia de registros para banderas
    register #(.n(1)) reg_N_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_N),
        .q(N)
    );

    register #(.n(1)) reg_Z_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_Z),
        .q(Z)
    );

    register #(.n(1)) reg_C_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_C),
        .q(C)
    );

    register #(.n(1)) reg_V_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_V),
        .q(V)
    );

endmodule
