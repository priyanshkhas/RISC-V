module fetch_cycle(
    input clk, rst,
    input PCSrcE,
    input [31:0] PCTargetE,
    output [31:0] InstrD,
    output [31:0] PCD, PCPlus4D
);

    // Intermediate wires
    wire [31:0] PC_F, PCF, PCPlus4F;
    wire [31:0] InstrF;

    // Pipeline registers
    reg [31:0] InstrF_reg;
    reg [31:0] PCF_reg, PCPlus4F_reg;

    // PC Mux: Choose between PC+4 and PCTargetE
    Mux PC_MUX (
        .a(PCPlus4F),
        .b(PCTargetE),
        .s(PCSrcE),
        .c(PC_F)
    );

    // Program Counter
    PC_Module Program_Counter (
        .clk(clk),
        .rst(rst),
        .PC(PCF),
        .PC_Next(PC_F)
    );

    // Instruction Memory
    Instruction_Memory IMEM (
        .rst(rst),
        .A(PCF),
        .RD(InstrF)
    );

    // PC + 4
    PC_Adder PC_adder (
        .a(PCF),
        .b(32'h00000004),
        .c(PCPlus4F)
    );

    // Registering fetch outputs
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            InstrF_reg <= 32'h00000000;
            PCF_reg <= 32'h00000000;
            PCPlus4F_reg <= 32'h00000000;
        end else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end

    // Output assignments
    assign InstrD = (!rst) ? 32'h00000000 : InstrF_reg;
    assign PCD = (!rst) ? 32'h00000000 : PCF_reg;
    assign PCPlus4D = (!rst) ? 32'h00000000 : PCPlus4F_reg;

endmodule

