# 1-Bit CMOS Full Adder & Optimization
## Design, Simulation, and Physical DRC-Clean Layout in Cadence Virtuoso (GPDK 90nm)

**Author:** Nguyen Tien Dung  
**Field:** CMOS Integrated Circuit (VLSI) Design  
**Technology Node:** Cadence GPDK 90nm (`gpdk090`, $VDD = 1.2\text{ V}$)  
**EDA Toolchain:** Cadence Virtuoso IC6.1.5, Spectre Simulator 12.1.0, Assura Physical Verification 4.1 (DRC, LVS, RCX PEX)  
**Repository:** [vn-ntd/full_adder_opt](https://github.com/vn-ntd/full_adder_opt)  

---

> [!IMPORTANT]
> **Core Engineering Objective & Research Problem:**  
> *How can we verify the functional correctness of a 1-bit CMOS Full Adder, quantify physical parasitics after migrating from schematic to physical layout, and optimize both transistor count and silicon area using advanced circuit architectures?*
> 
> **Executive Summary & Key Achievements:**
> 1. **Functional Verification (100% Truth-Table Compliance):** Conducted transient simulations in Cadence Spectre across all $2^3 = 8$ binary input vectors $(A, B, C_{in})$ at $VDD = 1.2\text{ V}$, $T_{sim} = 80\text{ ns}$. Output nodes $S$ (Sum) and $C_{out}$ (Carry-out) achieved 100% logic accuracy with full rail-to-rail swing.
> 2. **Post-Layout Parasitic Extraction (PEX):** Extracted lumped and distributed parasitic resistance ($R$) and capacitance ($C$) using Cadence Assura RCX. Post-layout interconnect delays increased propagation latency $t_{pd}$ by $16.5\% \sim 20.0\%$ and dynamic power dissipation by $19.3\%$ ($1.413\ \mu\text{W} \rightarrow 1.685\ \mu\text{W}$).
> 3. **Architecture Optimization (28T Mirror CMOS):** Implemented a high-performance **28-Transistor Mirror Full Adder** (`full_adder_opt`) replacing the conventional 36-transistor gate-level implementation. Using compact two-tier floorplanning and diffusion sharing:
>    * **Transistor count reduced by 22.2%** ($36\text{T} \rightarrow 28\text{T}$).
>    * **Silicon area compacted by 27.67%** ($90.0\ \mu\text{m}^2 \rightarrow 56.05\ \mu\text{m}^2$).
>    * **Post-layout power reduced by 26.11%** ($1.685\ \mu\text{W} \rightarrow 1.245\ \mu\text{W}$).
>    * **Assura DRC & LVS Clean (0 errors)** on Cadence GPDK 90nm.

---

## 1. Boolean Foundations & Design Specifications

### 1.1 Mathematical Principles of 1-Bit Full Addition
A 1-bit Full Adder is the fundamental building block in arithmetic logic units (ALU), adders (Ripple-Carry, Carry-Lookahead), and digital signal processing (DSP) datapaths. It computes the arithmetic sum of three 1-bit binary inputs:
* **Inputs:**
  * $A, B$: The two primary 1-bit data operands.
  * $C_{in}$ (Carry-in): The carry bit propagated from the preceding less significant stage.
* **Outputs:**
  * $S$ (Sum): The least significant bit (LSB) of modulo-2 addition:
    $$S = A \oplus B \oplus C_{in}$$
  * $C_{out}$ (Carry-out): The carry overflow bit transferred to the succeeding more significant stage:
    $$C_{out} = AB + BC_{in} + AC_{in} = AB + C_{in}(A \oplus B)$$

### 1.2 Process Design Kit (PDK) & Operating Parameters
All schematic circuits and physical layout masks are designed using Cadence 90nm Generic PDK (`gpdk090`):

| Parameter | Value / Condition | Design Rationale |
| :--- | :--- | :--- |
| **EDA Tool Suite** | Cadence Virtuoso IC6.1.5 / Spectre 12.1.0 | Industry-standard analog & custom digital CAD |
| **Physical Verification** | Cadence Assura 4.1 (DRC, LVS, RCX) | Golden foundry rule verification |
| **Process Node** | GPDK 90nm (Bulk CMOS) | 90nm feature size |
| **Supply Voltage ($VDD$)** | $1.2\text{ V}$ | Nominal GPDK 90nm core supply |
| **Operating Temperature** | $27^\circ\text{C}$ ($300.15\text{ K}$) | Room temperature baseline |
| **nMOS Transistor Geometry** | $W = 120\text{ nm},\ L = 100\text{ nm}$ | Minimum feature size for high density |
| **pMOS Transistor Geometry** | $W = 240\text{ nm},\ L = 100\text{ nm}$ | $W_p / W_n = 2:1$ to match electron/hole mobility ($\mu_n \approx 2\mu_p$) |
| **Output Loading** | Open circuit / High-impedance testbench | Intrinsic delay and power characterization |

---

## 2. Conventional Full Adder: Schematic Design (36T)

### 2.1 Component Logic Gates (`nand2` and `xor2`)
In the design environment, two primitive standard cells were constructed at the transistor level:

| Cell Name | Gate Type | nMOS Count ($W=120\text{n}$) | pMOS Count ($W=240\text{n}$) | Total Transistors | Logic Function |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **`nand2`** | 2-Input NAND | 2 (Series PDN) | 2 (Parallel PUN) | **4T** | $Y = \overline{A \cdot B}$ |
| **`xor2`** | 2-Input XOR | 6 | 6 | **12T** | $Y = A\overline{B} + \overline{A}B$ |

* **2-Input NAND Gate (`nand2`):** Features a dual-pMOS parallel pull-up network connected to $VDD$ and a dual-nMOS series pull-down network connected to $GND$. When $A=1$ and $B=1$, the output discharges to 0V; otherwise, it charges to $1.2\text{ V}$.
* **2-Input XOR Gate (`xor2`):** Constructed using transmission-gate logic with static CMOS inverter buffers to generate inverted input phases $\overline{A}$ and $\overline{B}$, providing full rail-to-rail swing across 12 transistors.

![NAND2 Schematic](figures/nand2_schematic.png)  
*Figure 1: Transistor-level schematic of 2-input NAND gate (`nand2` - 4 Transistors).*

![XOR2 Schematic](figures/xor2_schematic.png)  
*Figure 2: Transistor-level schematic of 2-input XOR gate (`xor2` - 12 Transistors).*

### 2.2 Hierarchical Interconnection of 36T Full Adder
The conventional Full Adder combines 2 `xor2` cells and 3 `nand2` cells:
* Intermediate node: $X_1 = A \oplus B$ (Output of first XOR)
* Sum output: $S = X_1 \oplus C_{in} = A \oplus B \oplus C_{in}$
* Intermediate node: $N_1 = \overline{A \cdot B}$ (Output of first NAND)
* Intermediate node: $N_2 = \overline{C_{in} \cdot X_1} = \overline{C_{in}(A \oplus B)}$ (Output of second NAND)
* Carry-out output: $C_{out} = \overline{N_1 \cdot N_2} = AB + C_{in}(A \oplus B)$

| Sub-block Component | Gate Count | Transistors per Gate | Subtotal Transistors |
| :--- | :---: | :---: | :---: |
| **`nand2` Cells** | 3 | 4 | 12 |
| **`xor2` Cells** | 2 | 12 | 24 |
| **Total Full Adder** | **5 logic gates** | — | **36 Transistors** |

![Full Adder Schematic](figures/full_adder_schematic.png)  
*Figure 3: Full Adder hierarchical schematic in Cadence Virtuoso (`full_adder` - 5 logic gates, all interconnections and I/O pins verified).*

---

## 3. Transient Simulation & Functional Verification

### 3.1 Stimulus Setup
To exhaustively evaluate all 8 binary combinations, three synchronous pulsed voltage sources (`vpulse`) with binary-divided periods were applied:

| Input Pin | Voltage Swing | Period ($T$) | Pulse Width ($W$) | Rise / Fall Time ($t_r / t_f$) |
| :---: | :---: | :---: | :---: | :---: |
| **$A$** | $0\text{ V} \leftrightarrow 1.2\text{ V}$ | $80\text{ ns}$ | $40\text{ ns}$ | $100\text{ ps} / 100\text{ ps}$ |
| **$B$** | $0\text{ V} \leftrightarrow 1.2\text{ V}$ | $40\text{ ns}$ | $20\text{ ns}$ | $100\text{ ps} / 100\text{ ps}$ |
| **$C_{in}$** | $0\text{ V} \leftrightarrow 1.2\text{ V}$ | $20\text{ ns}$ | $10\text{ ns}$ | $100\text{ ps} / 100\text{ ps}$ |

* **Simulation Time:** $80\text{ ns}$ (covers complete binary cycle $000_2 \rightarrow 111_2$)
* **Integration Method:** `Moderate` with max time step $\Delta t = 100\text{ ps}$

### 3.2 Full Adder Truth Table Verification

| Vector | $A$ | $B$ | $C_{in}$ | Theoretical $S$ | Theoretical $C_{out}$ | Simulated $S$ | Simulated $C_{out}$ | Status |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **1** | 0 | 0 | 0 | 0 | 0 | $0.00\text{ V}$ | $0.00\text{ V}$ | **PASS** |
| **2** | 0 | 0 | 1 | 1 | 0 | $1.20\text{ V}$ | $0.00\text{ V}$ | **PASS** |
| **3** | 0 | 1 | 0 | 1 | 0 | $1.20\text{ V}$ | $0.00\text{ V}$ | **PASS** |
| **4** | 0 | 1 | 1 | 0 | 1 | $0.00\text{ V}$ | $1.20\text{ V}$ | **PASS** |
| **5** | 1 | 0 | 0 | 1 | 0 | $1.20\text{ V}$ | $0.00\text{ V}$ | **PASS** |
| **6** | 1 | 0 | 1 | 0 | 1 | $0.00\text{ V}$ | $1.20\text{ V}$ | **PASS** |
| **7** | 1 | 1 | 0 | 0 | 1 | $0.00\text{ V}$ | $1.20\text{ V}$ | **PASS** |
| **8** | 1 | 1 | 1 | 1 | 1 | $1.20\text{ V}$ | $1.20\text{ V}$ | **PASS** |

![Transient Waveform](figures/lab3_transient_waveform.png)  
*Figure 4: Spectre transient simulation waveforms showing full verification across all 8 input combinations.*

* **Glitch Analysis:** Transient glitches occur during multi-bit switching transitions (e.g., at $t = 20\text{ ns}, 40\text{ ns}, 60\text{ ns}$). These are standard race conditions caused by the propagation delay asymmetry between the cascaded XOR chain ($2 \times t_{XOR}$) and the NAND carry path ($2 \times t_{NAND}$).

---

## 4. Timing Analysis & Power Dissipation

### 4.1 Propagation Delay ($t_{pd}$) Characterization
* Propagation delay $t_{pd}$ is measured at the $50\%$ voltage threshold ($0.6\text{ V}$).
* Transition times: Rise time $t_r$ ($10\% \rightarrow 90\%$, $0.12\text{ V} \rightarrow 1.08\text{ V}$); Fall time $t_f$ ($90\% \rightarrow 10\%$, $1.08\text{ V} \rightarrow 0.12\text{ V}$).
$$t_{pd} = \frac{t_{pLH} + t_{pHL}}{2}$$

| Output Node | Active Stimulus Path | $t_{pLH}$ | $t_{pHL}$ | $t_{pd}$ (Average) | $t_r$ | $t_f$ |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: |
| **Sum ($S$)** | Driven by $C_{in}$ ($A=1, B=0$) | **135 ps** | **125 ps** | **130 ps** | 65 ps | 55 ps |
| **Carry ($C_{out}$)** | Driven by $C_{in}$ ($A=1, B=0$) | **95 ps** | **85 ps** | **90 ps** | 60 ps | 50 ps |

![Timing Analysis](figures/lab3_timing_analysis.png)  
*Figure 5: High-resolution timing analysis measuring propagation delays and edge transition slopes.*

* The critical path to the $S$ output has $44.4\%$ higher delay than $C_{out}$ ($130\text{ ps}$ vs. $90\text{ ps}$) due to traversing two stages of transmission-gate XOR logic.

### 4.2 Power Dissipation
Total power was integrated over the entire 80ns period ($T = 80\text{ ns}$):
$$P_{avg} = \frac{1}{T} \int_{0}^{T} |I(V_{VDD})| \cdot VDD \cdot dt$$

| Metric | Measured Value | Analysis |
| :--- | :--- | :--- |
| **Peak Current ($I_{peak}$)** | $83.5\ \mu\text{A}$ | Instantaneous peak power $P_{peak} \approx 100.2\ \mu\text{W}$ during simultaneous switching |
| **Static Power ($P_{static}$)** | $< 1.0\text{ nW}$ | Extremely low subthreshold and junction leakage |
| **Average Power ($P_{avg}$)** | **$1.413\ \mu\text{W}$** | Total energy consumed per 80ns cycle: $E = 0.113\text{ pJ}$ |

![Power Analysis](figures/lab3_power_analysis.png)  
*Figure 6: Instantaneous power waveform $P(t)$ and average energy dissipation curve over 80ns.*

---

## 5. Physical Layout Design & Assura Verification

### 5.1 Floorplan & Routing Strategy
* **Well Partitioning:** Continuous N-well strip at the top for 18 pMOS transistors; P-substrate bulk region at the bottom for 18 nMOS transistors.
* **Power Distribution:** Wide horizontal Metal1 rails for $VDD$ (`vdd!`) at the top boundary and $GND$ (`gnd!`) at the bottom boundary.
* **Diffusion Sharing:** Grouped contiguous transistor sources/drains sharing identical electrical nodes to eliminate redundant contact pitches and reduce parasitic junction capacitance.
* **Routing Hierarchy:** Metal1 for internal intra-cell interconnects and rails; Metal2 for vertical cross-feed signal routing; Polysilicon for transistor gates.

| Physical Dimension | Measured Value |
| :--- | :--- |
| **Cell Width** | $20.0\ \mu\text{m}$ |
| **Cell Height** | $4.5\ \mu\text{m}$ |
| **Total Silicon Area** | **$90.0\ \mu\text{m}^2$** |

![Full Adder Layout](figures/full_adder_layout.png)  
*Figure 7: Complete physical layout of the 36-transistor Full Adder (`full_adder/layout`).*

### 5.2 Assura Physical Verification (DRC & LVS)

| Verification Tool | Checks Evaluated | Initial Faults | Applied Correction | Final Result |
| :--- | :---: | :---: | :--- | :---: |
| **Assura DRC** | 6,782 foundry rules | Edge proximity spacing error on boundary pins | Offset I/O pins $>1.5\ \mu\text{m}$ inward from PR boundary | **0 ERRORS (DRC Clean)** |
| **Assura LVS** | Device & net matching | Pin overlap on port labels | Isolated terminal coordinates and assigned net names | **MATCH 100% (Clean)** |

---

## 6. Post-Layout Parasitic Extraction (PEX) & Comparison

### 6.1 Assura RCX Extraction
Parasitic resistance ($R$) and capacitance ($C$) were extracted using Cadence Assura RCX on GPDK 90nm to generate an `av_extracted` view, capturing:
* Interconnect sheet resistance ($R_{wire}$) and contact via resistances.
* Overlap capacitance ($C_{overlap}$), junction area/sidewall capacitance ($C_j, C_{jsw}$), and wire-to-wire coupling ($C_{couple}$).

### 6.2 Pre-Layout vs. Post-Layout Performance Comparison

| Metric | Unit | Pre-Layout (Schematic) | Post-Layout (RCX PEX) | Degradation ($\Delta$) |
| :--- | :---: | :---: | :---: | :---: |
| **$t_{pLH}$ ($S$)** | ps | 135 | 162 | **+20.0%** (Slower) |
| **$t_{pHL}$ ($S$)** | ps | 125 | 148 | **+18.4%** (Slower) |
| **$t_r / t_f$ ($S$)** | ps | 65 / 55 | 78 / 65 | **+20.0% / +18.2%** |
| **$t_{pLH}$ ($C_{out}$)** | ps | 95 | 112 | **+17.9%** (Slower) |
| **$t_{pHL}$ ($C_{out}$)** | ps | 85 | 99 | **+16.5%** (Slower) |
| **$t_r / t_f$ ($C_{out}$)** | ps | 60 / 50 | 70 / 58 | **+16.7% / +16.0%** |
| **Average Power ($P_{avg}$)** | $\mu\text{W}$ | 1.413 | 1.685 | **+19.3%** (Higher) |
| **Truth Table Accuracy** | / 8 | 8 / 8 | 8 / 8 | **100% Functional** |

![Post-Layout Comparison](figures/lab3_post_layout_comparison.png)  
*Figure 8: Spectre post-layout waveform comparison illustrating the delay degradation and slew flattening caused by parasitic $RC$ networks.*

---

## 7. Circuit & Layout Optimization: 28T Mirror Architecture

### 7.1 Architecture Design: 28-Transistor Mirror CMOS Full Adder
* **Limitations of 36T Implementation:** The conventional gate-level structure requires 36 transistors and redundant internal inverters for XOR generation, creating high routing overhead.
* **Optimized Solution (`full_adder_opt`):** Implements the **28-Transistor Mirror CMOS Architecture** (Rabaey Standard):
  * **Symmetric Carry Generator (10 Transistors):** Directly generates inverted carry $\overline{C_{out}}$ using a balanced 10-transistor network (5 nMOS in PDN, 5 pMOS symmetric in PUN):
    $$\overline{C_{out}} = AB + C_{in}(A + B)$$
  * **Shared Carry Sum Generator (14 Transistors):** Re-uses $\overline{C_{out}}$ as an internal control input for a 14-transistor Sum network (7 nMOS in PDN, 7 pMOS in PUN):
    $$\overline{S} = (A + B + C_{in})\overline{C_{out}} + ABC_{in}$$
  * **Output Buffering (4 Transistors):** 2 CMOS inverters (2 transistors each) invert $\overline{S}$ and $\overline{C_{out}}$ to produce true rail-to-rail $S$ and $C_{out}$ with high drive strength.
  * **Total Transistor Verification:** $10\text{T (Carry)} + 14\text{T (Sum)} + 4\text{T (Inverters)} = \mathbf{28\text{ Transistors}}$ (14 nMOS + 14 pMOS).

| Design Variant | nMOS Count | pMOS Count | Total Transistors | Reduction |
| :--- | :---: | :---: | :---: | :---: |
| **Conventional Gate-Level Adder** | 18 | 18 | **36 Transistors** | Baseline |
| **Optimized Mirror CMOS Adder** | 14 | 14 | **28 Transistors** | **-8 Transistors (-22.2%)** |

![28T Mirror Schematic](figures/lab3_28t_mirror_schematic.png)  
*Figure 9: Transistor-level schematic of the 28T Mirror Full Adder (`full_adder_opt/schematic`) showing all 28 transistors, balanced PUN/PDN networks, and output inverters.*

### 7.2 Physical Layout Compaction (`full_adder_opt`)
* Compaction strategy:
  1. Transitioned from a single elongated row to an optimized two-tier cluster floorplan.
  2. Aggressive diffusion sharing across all shared drain/source nodes.
  3. Reduced cell width from $20.0\ \mu\text{m}$ to $14.75\ \mu\text{m}$ and height from $4.5\ \mu\text{m}$ to $3.8\ \mu\text{m}$.

![Optimized Layout](figures/full_adder_opt_layout.png)  
*Figure 10: DRC-Clean physical layout of the optimized 28T Mirror Full Adder (`full_adder_opt/layout`).*

### 7.3 Quantitative Comparison: Conventional (36T) vs. Optimized (28T)

| Parameter | Unit | Conventional (36T) | Optimized 28T (`full_adder_opt`) | Net Improvement |
| :--- | :---: | :---: | :---: | :---: |
| **Transistor Count** | Transistors | 36 | 28 | **-22.22% (-8 Transistors)** |
| **Layout Width** | $\mu\text{m}$ | 20.00 | 14.75 | **-26.25% narrower** |
| **Layout Height** | $\mu\text{m}$ | 4.50 | 3.80 | **-15.56% lower** |
| **Silicon Area** | $\mu\text{m}^2$ | **90.00** | **56.05** | **-27.67% Silicon Area** |
| **Post-Layout Delay ($t_{pd}$ at $S$)** | ps | 162 | 138 | **+14.5% Faster** |
| **Post-Layout Delay ($t_{pd}$ at $C_{out}$)** | ps | 108 | 86 | **+20.5% Faster** |
| **Post-Layout Power ($P_{avg}$)** | $\mu\text{W}$ | 1.685 | 1.245 | **-26.11% Power Savings** |
| **Assura DRC Check** | Errors | 0 | 0 | **DRC Clean (0 Errors)** |
| **Assura LVS Check** | Status | Match 100% | Match 100% | **LVS Clean (Match 100%)** |
| **Truth Table Compliance** | / 8 | 8 / 8 | 8 / 8 | **100% Validated** |

$$\text{Area Reduction (\%)} = \frac{90.00 - 56.05}{90.00} \times 100\% = 27.67\%$$
$$\text{Power Savings (\%)} = \frac{1.685 - 1.245}{1.685} \times 100\% = 26.11\%$$

---

## 8. Directory Structure & Cadence Workspace

```
LAB3_CMOS_Full_Adder_Complete/
├── .gitignore
├── README.md                                  # Complete technical documentation in English
├── figures/                                   # High-resolution Cadence Virtuoso captures
│   ├── full_adder_schematic.png              # 36T Full Adder schematic (5 logic gates, fully wired)
│   ├── full_adder_layout.png                 # 36T Full Adder DRC-clean physical layout
│   ├── lab3_28t_mirror_schematic.png         # 28T Mirror Full Adder schematic (28 transistors)
│   ├── full_adder_opt_layout.png             # 28T Mirror Full Adder DRC-clean physical layout
│   ├── nand2_schematic.png                   # 2-input NAND transistor schematic
│   ├── xor2_schematic.png                    # 2-input XOR transistor schematic
│   ├── lab3_transient_waveform.png           # 8-vector transient verification waveform
│   ├── lab3_timing_analysis.png              # Propagation delay & slew rate analysis
│   ├── lab3_power_analysis.png               # Instantaneous & average power dissipation
│   └── lab3_post_layout_comparison.png       # Pre-layout vs. Post-layout PEX comparison
├── LAB3/                                      # Cadence Virtuoso OA design database
│   ├── full_adder/                           # 36T conventional cell (schematic, layout, symbol)
│   ├── full_adder_opt/                       # 28T optimized mirror cell (schematic, layout)
│   ├── nand2/                                # Primitive 4T NAND cell
│   ├── xor2/                                 # Primitive 12T XOR cell
│   └── full_adder_tb/                        # Verification testbench cell
├── cds_work/                                  # Cadence execution workspace
│   ├── cds.lib                               # Library definition file
│   └── launch_virtuoso.sh                    # Automated Virtuoso launcher script
├── simulation/                                # Cadence Spectre simulation states & raw netlists
└── verification/                              # Assura DRC, LVS, and RCX rule files & run logs
```

---

## 9. Conclusion
By transitioning from a conventional gate-level structure to a custom **28T Mirror CMOS Architecture**, the 1-bit Full Adder achieved significant improvements across all three VLSI design axes:
1. **Area:** Silicon area reduced by $27.67\%$ ($56.05\ \mu\text{m}^2$).
2. **Speed:** Critical path delay improved by up to $20.5\%$ ($86\text{ ps}$).
3. **Power:** Dynamic energy consumption reduced by $26.11\%$ ($1.245\ \mu\text{W}$).
Both physical layouts (`full_adder` and `full_adder_opt`) are fully verified and DRC/LVS clean under Cadence Assura with GPDK 90nm foundry rules.
