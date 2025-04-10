## RISC-V 5-Stage Pipelined Processor

This repository contains the design and implementation of a **RISC-V pipelined processor** using a classic **5-stage pipeline architecture**. The design is modular and includes handling for pipeline hazards using both NOPs and data forwarding mechanisms.

---

### 📌 Key Features

- Implements **5-stage pipelining**: Fetch, Decode, Execute, Memory, Write Back
- Supports basic RISC-V instructions
- Forwarding logic to handle data hazards
- Simple hazard detection unit
- Modular design for easy understanding and simulation

---

## 🧠 Pipeline Architecture

The processor follows the classic 5-stage pipeline model:

| Stage     | Name       | Description                                                |
|-----------|------------|------------------------------------------------------------|
| Stage 1   | **Fetch**  | Fetches instruction from memory                            |
| Stage 2   | **Decode** | Decodes instruction and reads required registers           |
| Stage 3   | **Execute**| Performs ALU operations or calculates memory addresses     |
| Stage 4   | **Memory** | Accesses data memory for loads and stores                  |
| Stage 5   | **Write Back** | Writes the result back to the register file           |

Each stage has its own dedicated pipeline registers for forwarding results to the next stage.

---

### 🧩 Modules and Components

#### **Fetch Stage**
- `Program Counter (PC)`
- `PC Adder (PC + 4)`
- `Instruction Memory`
- `PC Mux` (for branching)
- `Fetch Register`

#### **Decode Stage**
- `Control Unit`
- `Register File`
- `Immediate Extender`
- `Decode Register`

#### **Execute Stage**
- `ALU`
- `ALU Control Unit`
- `Forwarding Muxes`
- `Execute Register`

#### **Memory Stage**
- `Data Memory`
- `Memory Register`

#### **Write Back Stage**
- `Writeback Mux` (selects between ALU or Memory output)

---

## 🚧 Pipeline Hazards

### 1️⃣ Structural Hazards
- **Cause:** Conflict in accessing shared resources (e.g., single memory block)
- **Solution:** Use separate instruction and data memories

### 2️⃣ Data Hazards
- **Cause:** Instruction depends on result of a previous instruction
- **Solution:**
  - **NOP Insertion**
  - **Data Forwarding (Bypassing)**

### 🔁 Forwarding Logic

```verilog
if (RegWriteM && (RdM != 0) && (RdM == Rs1E)) ForwardAE = 10;
if (RegWriteM && (RdM != 0) && (RdM == Rs2E)) ForwardBE = 10;
if (RegWriteW && (RdW != 0) && (RdW == Rs1E)) ForwardAE = 01;
if (RegWriteW && (RdW != 0) && (RdW == Rs2E)) ForwardBE = 01;

## ** Project Structure**
riscv-pipeline/
│
├── Fetch/                 # Modules and registers for Fetch Stage
├── Decode/                # Modules for Decode and Control logic
├── Execute/               # ALU and control modules
├── Memory/                # Data memory and related control
├── WriteBack/             # Mux logic for writeback
├── HazardUnit/            # Forwarding logic and hazard detection
├── PipelineTop/           # Top-level module integrating all components
└── README.md              # This documentation file



💡 Future Work
1.Add support for branch prediction

2.Implement control hazard resolution (delayed branch, flushing)

3.Expand instruction set (CSR, M extension)

4.Integrate testbench and waveform viewer
