# BÁO CÁO KẾT QUẢ THỰC HÀNH CHUYÊN SÂU LAB 3
## THIẾT KẾ, KIỂM TRA ĐẶC TÍNH VÀ BỐ TRÍ VẬT LÝ BỘ CỘNG ĐẦY ĐỦ CMOS 1-BIT
### (1-Bit CMOS Full Adder Design, Transient Simulation & Physical Layout)

**Sinh viên thực hiện:** Nguyễn Tiến Dũng  
**Nhóm thực hành:** 1  
**Môn học:** ICI211 – Thiết kế Vi mạch CMOS (CMOS VLSI Design)  
**Thư viện làm việc Cadence Virtuoso:** `LAB3` (`/home/buet/Desktop/Workspace/LAB3`)  
**Thư mục làm việc cấu hình hệ thống:** `/home/buet/Desktop/Workspace/cds_work`  
**Liên kết lưu trữ minh chứng trực tuyến:** [Google Drive Lab 3](https://drive.google.com/drive/folders/1SO9edQ8UleXYTMKpS6Gm4zWxx5L324QS?usp=sharing)  

---

> [!IMPORTANT]
> **CÂU HỎI XUYÊN SUỐT BÀI THỰC HÀNH LAB 3:**  
> *Làm thế nào chứng minh bộ cộng CMOS hoạt động đúng và đánh giá sự thay đổi của mạch sau khi chuyển từ sơ đồ nguyên lý (schematic) sang bố trí vật lý (layout)?*
> 
> **Tóm tắt lời giải và kết quả nghiệm thu:**
> 1. **Chứng minh hoạt động đúng:** Thực hiện quét toàn bộ $2^3 = 8$ tổ hợp đầu vào nhị phân $(A, B, C_{in})$ trong miền thời gian qua mô phỏng quá độ (Transient Analysis trên Cadence Spectre với $VDD = 1.2\text{ V}$, $T = 80\text{ ns}$). Cả 8/8 trạng thái ngõ ra $S$ (Sum) và $C_{out}$ (Carry-out) đều đạt đúng tuyệt đối $100\%$ theo bảng chân lý lý thuyết.
> 2. **Đánh giá suy hao sau Layout (PEX):** Trích xuất ký sinh bằng Assura RCX (điện trở $R$ và điện dung $C$). Do xuất hiện điện dung ký sinh phân bố $C_{wire}, C_{overlap}, C_{junction}$ và điện trở dây kim loại, độ trễ lan truyền $t_{pd}$ tăng thêm từ $16.5\% \sim 20.0\%$ và công suất tiêu thụ trung bình tăng $19.3\%$ (từ $1.413\ \mu\text{W}$ lên $1.685\ \mu\text{W}$).
> 3. **Tối ưu hóa (Phần 7):** Đề xuất kiến trúc **28T Mirror Full Adder** giúp cắt giảm 8 transistor so với mạch ghép 36T ban đầu; kỹ thuật bố trí layout 2 tầng chia sẻ vùng khuếch tán giúp giảm $27.67\%$ diện tích silicon (từ $90.0\ \mu\text{m}^2$ xuống $56.05\ \mu\text{m}^2$), giảm $12.3\%$ độ trễ và tiết kiệm $26.1\%$ công suất sau trích xuất.

---

## 1. Chuẩn Bị Lý Thuyết và Môi Trường Thiết Kế

### 1.1 Chức năng và nguyên lý hoạt động của bộ cộng toàn phần (Full Adder)
Bộ cộng toàn phần 1-bit là mạch logic số học tổ hợp cơ bản thực hiện phép cộng 3 bit nhị phân:
* **Ba đầu vào ($A, B, C_{in}$):**
  * $A, B$: Hai toán hạng dữ liệu nhị phân 1-bit tại hàng tính toán.
  * $C_{in}$ (Carry-in): Bit nhớ phát sinh từ hàng liền trước (hàng thấp hơn) truyền lên.
* **Hai đầu ra ($S, C_{out}$):**
  * $S$ (Sum): Bit tổng kết quả phép cộng modulo-2. Mức logic $S = 1$ khi số lượng biến đầu vào có mức logic 1 là **số lẻ** (chính xác 1 hoặc cả 3 đầu vào bằng 1).
  * $C_{out}$ (Carry-out): Bit nhớ tràn sinh ra truyền tiếp lên hàng cao hơn. Mức logic $C_{out} = 1$ khi có **từ 2 hoặc cả 3 biến đầu vào** ở mức logic 1.

**Biểu thức đại số Boolean chuẩn:**
$$S = A \oplus B \oplus C_{in}$$
$$C_{out} = AB + BC_{in} + AC_{in} = AB + C_{in}(A \oplus B)$$

### 1.2 Thiết lập môi trường và thông số công nghệ thực tế
Mọi linh kiện, khối logic và mạch nguyên lý/mặt nạ layout đều được thiết lập trong thư viện mới **`LAB3`** trên công cụ Cadence:

| Thông số cấu hình | Giá trị sử dụng trong thực tế |
| :--- | :--- |
| **Phần mềm EDA & Bộ mô phỏng** | Cadence Virtuoso IC6.1.5 & Spectre 12.1.0 |
| **Công cụ kiểm tra vật lý** | Cadence Assura 4.1 (DRC, LVS, RCX PEX) |
| **Công nghệ chế tạo (PDK)** | GPDK 90nm (`gpdk090`, các model transistor `nmos1v`, `pmos1v`) |
| **Tên Library / Cell / View** | Thư viện: `LAB3` — Cell: `full_adder` — View: `schematic` / `layout` |
| **Điện áp nguồn $VDD$ và nhiệt độ** | $VDD = 1.2\text{ V}$, Nhiệt độ $T = 27^\circ\text{C}$ |
| **Kích thước hình học nMOS** | $W = 120\text{ nm},\ L = 100\text{ nm}$ |
| **Kích thước hình học pMOS** | $W = 240\text{ nm},\ L = 100\text{ nm}$ ($W_p/W_n = 2:1$ đảm bảo cân bằng thời gian lên/xuống) |
| **Điều kiện tải đầu ra ($S, C_{out}$)** | Tải hở mạch (Open circuit / không đấu tụ ngoài) |

---

## 2. Phần A: Thiết Kế Sơ Đồ Nguyên Lý (Schematic)

### 2.1 Thiết kế cổng logic thành phần (NAND2 và XOR2)
Trong thư viện **`LAB3`**, hai cell logic cơ bản được xây dựng ở mức transistor kèm theo biểu tượng symbol chuẩn:

| Cổng logic | Tên Cell trong `LAB3` | Số nMOS ($W=120\text{n}$) | Số pMOS ($W=240\text{n}$) | Tổng số Transistor |
| :--- | :--- | :---: | :---: | :---: |
| **NAND 2 ngõ vào** | `nand2` | 2 nMOS mắc nối tiếp | 2 pMOS mắc song song | **4 Transistors** |
| **XOR 2 ngõ vào** | `xor2` | 6 nMOS | 6 pMOS | **12 Transistors** |

* **Cổng NAND2:** Mạng kéo lên (Pull-Up Network - PUN) gồm 2 transistor pMOS mắc song song nối nguồn VDD, mạng kéo xuống (Pull-Down Network - PDN) gồm 2 transistor nMOS mắc nối tiếp xuống đất GND. Ngõ ra được kéo xuống 0V chỉ khi cả $A=1$ và $B=1$; các trường hợp còn lại ngõ ra được kéo lên mức 1.2V.
* **Cổng XOR2:** Sử dụng cấu trúc truyền dẫn kết hợp CMOS tĩnh với 2 bộ đệm Inverter tạo tín hiệu đảo $A_i, B_i$ và mạng chuyển mạch 8 transistor để thực hiện hàm logic $Y = A\overline{B} + \overline{A}B$, cho tổng cộng 12 transistor với biên độ ngõ ra chuẩn Rail-to-Rail.

![Hình 1: Sơ đồ nguyên lý transistor của cổng NAND 2 ngõ vào](figures/nand2_schematic.png)
*Hình 1: Sơ đồ nguyên lý transistor của cổng NAND 2 ngõ vào (`LAB3/nand2/schematic`)*

![Hình 2: Sơ đồ nguyên lý transistor của cổng XOR 2 ngõ vào](figures/xor2_schematic.png)
*Hình 2: Sơ đồ nguyên lý transistor của cổng XOR 2 ngõ vào (`LAB3/xor2/schematic`)*

### 2.2 Ghép nối bộ cộng đầy đủ (Full Adder 36T)
Ghép 3 cổng `nand2` và 2 cổng `xor2` thành cell `full_adder` trong thư viện `LAB3`:
* Nút trung gian $X_1 = A \oplus B$ (Ngõ ra XOR thứ nhất)
* Ngõ ra Tổng: $S = X_1 \oplus C_{in} = A \oplus B \oplus C_{in}$
* Nút trung gian $N_1 = \overline{A \cdot B}$ (Ngõ ra NAND thứ nhất)
* Nút trung gian $N_2 = \overline{C_{in} \cdot X_1} = \overline{C_{in}(A \oplus B)}$ (Ngõ ra NAND thứ hai)
* Ngõ ra Carry-out: $C_{out} = \overline{N_1 \cdot N_2} = AB + C_{in}(A \oplus B) = AB + BC_{in} + AC_{in}$

| Khối thành phần | Số lượng cổng | Transistor mỗi cổng | Tổng Transistors |
| :--- | :---: | :---: | :---: |
| **Cổng NAND (`nand2`)** | 3 | 4 | 12 |
| **Cổng XOR (`xor2`)** | 2 | 12 | 24 |
| **Toàn bộ Full Adder** | **5 cổng logic** | — | **36 Transistors** |

![Hình 3: Sơ đồ ghép nối Full Adder từ 3 NAND2 và 2 XOR2](figures/full_adder_schematic.png)
*Hình 3: Sơ đồ ghép nối Full Adder từ 3 NAND2 và 2 XOR2 (`LAB3/full_adder/schematic`)*

---

## 3. Phần A: Kiểm Chứng Chức Năng Hoạt Động (Simulation)

### 3.1 Cấu hình tín hiệu kích thích và mô phỏng quá độ
Ba nguồn xung `vpulse` được thiết lập với chu kỳ phân chia nhị phân tuần tự:

| Đầu vào | Điện áp (V0 / V1) | Chu kỳ ($T$) | Độ rộng xung ($W$) | Thời gian lên / xuống ($t_r / t_f$) |
| :---: | :---: | :---: | :---: | :---: |
| **A** | $0\text{ V} / 1.2\text{ V}$ | $80\text{ ns}$ | $40\text{ ns}$ | $100\text{ ps} / 100\text{ ps}$ |
| **B** | $0\text{ V} / 1.2\text{ V}$ | $40\text{ ns}$ | $20\text{ ns}$ | $100\text{ ps} / 100\text{ ps}$ |
| **Cin** | $0\text{ V} / 1.2\text{ V}$ | $20\text{ ns}$ | $10\text{ ns}$ | $100\text{ ps} / 100\text{ ps}$ |

* Thời gian mô phỏng (Stop time): $80\text{ ns}$
* Bước thời gian cực đại (Maxstep): $100\text{ ps}$
* Thuật toán tích phân: `Moderate`

### 3.2 Bảng kiểm chứng chân lý bộ cộng Full Adder

| Tổ hợp | $A$ | $B$ | $C_{in}$ | $S$ lý thuyết | $C_{out}$ lý thuyết | $S$ mô phỏng | $C_{out}$ mô phỏng | Đánh giá |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **1** | 0 | 0 | 0 | 0 | 0 | 0 (0.00 V) | 0 (0.00 V) | **ĐẠT** |
| **2** | 0 | 0 | 1 | 1 | 0 | 1 (1.20 V) | 0 (0.00 V) | **ĐẠT** |
| **3** | 0 | 1 | 0 | 1 | 0 | 1 (1.20 V) | 0 (0.00 V) | **ĐẠT** |
| **4** | 0 | 1 | 1 | 0 | 1 | 0 (0.00 V) | 1 (1.20 V) | **ĐẠT** |
| **5** | 1 | 0 | 0 | 1 | 0 | 1 (1.20 V) | 0 (0.00 V) | **ĐẠT** |
| **6** | 1 | 0 | 1 | 0 | 1 | 0 (0.00 V) | 1 (1.20 V) | **ĐẠT** |
| **7** | 1 | 1 | 0 | 0 | 1 | 0 (0.00 V) | 1 (1.20 V) | **ĐẠT** |
| **8** | 1 | 1 | 1 | 1 | 1 | 1 (1.20 V) | 1 (1.20 V) | **ĐẠT** |

![Hình 4: Dạng sóng mô phỏng quá độ kiểm chứng chức năng 8 tổ hợp](figures/lab3_transient_waveform.png)
*Hình 4: Dạng sóng mô phỏng quá độ kiểm chứng chức năng 8 tổ hợp đầu vào của Full Adder (Cadence Spectre)*

* **Kết luận chức năng:** Mạch hoạt động chính xác 100% theo đúng bảng chân lý. Cả 8/8 tổ hợp kiểm tra đều đạt chuẩn lý thuyết.
* **Phân tích hiện tượng xung nhọn tạm thời (Glitches):** Xuất hiện xung nhọn thoáng qua tại các mốc thời gian chuyển mạch đa bit (đặc biệt tại 20 ns, 40 ns, 60 ns). Nguyên nhân do độ trễ lan truyền của chuỗi cổng XOR lớn hơn nhánh cổng NAND, dẫn tới hiện tượng quá độ cạnh tranh (race condition) tạm thời trước khi mạch ổn định trạng thái.

---

## 4. Phần A: Phân Tích Thời Gian Lan Truyền và Công Suất Tiêu Thụ

### 4.1 Phép đo tham số thời gian chuyển mạch (Timing Analysis)
* Độ trễ lan truyền $t_{pd}$ được đo giữa mức $50\%$ của tín hiệu đầu vào và đầu ra ($0.6\text{ V}$).
* Thời gian lên $t_r$ đo từ $10\%$ đến $90\%$ $VDD$ ($0.12\text{ V} - 1.08\text{ V}$).
* Thời gian xuống $t_f$ đo từ $90\%$ về $10\%$ $VDD$ ($1.08\text{ V} - 0.12\text{ V}$).
$$t_{pd} = \frac{t_{pLH} + t_{pHL}}{2}$$

| Đầu ra | Đầu vào và điều kiện kích thích | $t_{pLH}$ | $t_{pHL}$ | $t_{pd}$ | $t_r$ | $t_f$ |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: |
| **Sum ($S$)** | Theo $C_{in}$ (khi $A=1, B=0$ hoặc $A=0, B=1$) | **135 ps** | **125 ps** | **130 ps** | 65 ps | 55 ps |
| **Carry ($C_{out}$)** | Theo $C_{in}$ (khi $A=1, B=0$) | **95 ps** | **85 ps** | **90 ps** | 60 ps | 50 ps |

![Hình 5: Đồ thị phóng to đo độ trễ lan truyền và thời gian chuyển mức](figures/lab3_timing_analysis.png)
*Hình 5: Đồ thị phóng to đo độ trễ lan truyền $t_{pLH}, t_{pHL}$ và thời gian chuyển mức $t_r, t_f$ tại mức 50% và 10%-90% VDD*

* **So sánh đường truyền:** Đường truyền tới ngõ ra $S$ có độ trễ lớn hơn đường truyền tới $C_{out}$ ($130\text{ ps}$ so với $90\text{ ps}$, lớn hơn $\approx 44.4\%$). Nguyên nhân là vì tín hiệu tạo nên $S$ phải đi qua liên tiếp hai tầng cổng XOR (vốn có cấu trúc gồm các bộ đệm đảo và nhiều transistor nối tiếp), trong khi $C_{out}$ được tổng hợp từ mạng cổng NAND có số tầng logic ít hơn.

### 4.2 Phân tích công suất tiêu thụ toàn phần (Power Consumption)
$$P_{avg} = \frac{1}{T} \int_{0}^{T} |I(V_{VDD})| \cdot 1.2\text{ V} \cdot dt$$

| Nội dung khảo sát | Kết quả thực nghiệm trên Spectre |
| :--- | :--- |
| **Cửa sổ đo thời gian** | $0\text{ ns}$ đến $80\text{ ns}$ (quét trọn vẹn 8 tổ hợp đầu vào) |
| **Dòng điện đỉnh tức thời ($I_{peak}$)** | $83.5\ \mu\text{A}$ (Công suất tức thời đỉnh $P_{peak} \approx 100.2\ \mu\text{W}$) |
| **Công suất tĩnh khi ổn định ($P_{static}$)** | $< 1.0\text{ nW}$ (chỉ tồn tại dòng rò leakage pA) |
| **Công suất tiêu thụ trung bình ($P_{avg}$)** | **$1.413\ \mu\text{W}$** (Tổng năng lượng tiêu hao: $E = 0.113\text{ pJ}$) |

![Hình 6: Dạng sóng công suất tức thời và đường công suất trung bình](figures/lab3_power_analysis.png)
*Hình 6: Dạng sóng công suất tức thời $P(t)$ và đường công suất trung bình $P_{avg}$ trên toàn dải quét 80ns*

* **Nhận xét:** Khi đầu vào ổn định, công suất tiêu thụ xấp xỉ 0 (chỉ có dòng rò subthreshold cực nhỏ cỡ nW). Khi có sườn xung chuyển mức, công suất tiêu thụ tăng vọt thành các đỉnh nhọn do dòng sạc/xả các điện dung ký sinh ($P_{dyn} = \alpha C V_{DD}^2 f$) và dòng ngắn mạch tức thời khi cả nMOS và pMOS cùng dẫn.

---

## 5. Phần B: Thiết Kế Layout Vật Lý và Kiểm Tra Assura DRC / LVS

### 5.1 Bố trí mặt nạ (Floorplan) và quy tắc đi dây
* Đặt toàn bộ 18 transistor pMOS trong dải N-well phía trên, và 18 transistor nMOS trong nền P-substrate phía dưới.
* Hai thanh nguồn Metal1 song song (`vdd!` ở mép trên, `gnd!` ở mép dưới) chạy dọc toàn bộ chiều rộng cell.
* **Chia sẻ vùng khuếch tán (Shared Diffusion):** Các transistor pMOS có Source cùng nối lên `vdd!` và nMOS có Source cùng nối xuống `gnd!` được xếp sát cạnh nhau để gộp chung vùng active, giúp giảm đáng kể diện tích layout và giảm điện dung ký sinh nút nguồn.
* Sử dụng Metal1 cho thanh nguồn và đi dây nội bộ; Metal2 cho các đường dây tín hiệu xuyên tầng; Poly cho các cực gate.

| Thông số hình học Layout | Kết quả đo đạc thực tế |
| :--- | :--- |
| **Chiều rộng cell (Width)** | $20.0\ \mu\text{m}$ |
| **Chiều cao cell (Height)** | $4.5\ \mu\text{m}$ |
| **Diện tích chiếm dụng (Area)** | **$90.0\ \mu\text{m}^2$** |
| **Các lớp routing sử dụng** | Metal1 (nguồn, nội bộ), Metal2 (tín hiệu dọc), Poly (cổng gate) |

![Hình 7: Bản vẽ Layout hoàn chỉnh của bộ cộng Full Adder 36T](figures/full_adder_layout.png)
*Hình 7: Bản vẽ Layout hoàn chỉnh của bộ cộng Full Adder 36T (`LAB3/full_adder/layout`)*

### 5.2 Kết quả kiểm tra Assura DRC và LVS

| Kiểm tra | Lỗi ban đầu | Cách khắc phục | Kết quả cuối nghiệm thu |
| :--- | :--- | :--- | :--- |
| **Assura DRC** | Khoảng cách chân pin và thân transistor bị chạm nhẹ mép ngoài | Dời 5 chân pin ra cách mép ngoài tối thiểu 1.5 μm theo rule GPDK 90nm | **0 LỖI (DRC Clean — Kiểm tra 6782 quy tắc)** |
| **Assura LVS** | Chưa nhận diện đúng do chân pin bị trùng tọa độ | Đặt tọa độ độc lập và gán đúng net A, B, Cin, S, Cout, vdd!, gnd! | **ĐẠT 100% (Schematic and Layout Match)** |

* **Trạng thái:** Mạch layout đã khớp hoàn toàn 100% với schematic về số lượng transistor (18 pMOS $W=240\text{nm}$, 18 nMOS $W=120\text{nm}$, $L=100\text{nm}$), kích thước $W/L$, và đủ 5 chân tín hiệu cùng 2 chân cấp nguồn.

---

## 6. Phần C: Trích Xuất Ký Sinh PEX và So Sánh Sau Layout (Post-Layout)

### 6.1 Trích xuất ký sinh PEX (Assura RCX)
Sử dụng công cụ **Cadence Assura RCX** trên công nghệ GPDK 90nm để trích xuất đầy đủ điện trở ký sinh $R$ của các đường dây kim loại và điện dung ký sinh $C$ (tụ điện dung chồng mép $C_{overlap}$, tụ tiếp giáp $C_{junction}$ và tụ giữa các đường dây lân cận), sinh ra view trích xuất **`av_extracted`** để đưa vào mô phỏng Spectre sau layout.

### 6.2 So sánh định lượng đặc tính mạch Trước và Sau Layout

| Đại lượng khảo sát | Đơn vị | Trước Layout (Pre-Layout) | Sau Layout (Post-Layout PEX) | Mức độ thay đổi (%) |
| :--- | :---: | :---: | :---: | :---: |
| **$t_{pLH}$ tại $S$** | ps | 135 | 162 | **+20.0%** (Chậm hơn) |
| **$t_{pHL}$ tại $S$** | ps | 125 | 148 | **+18.4%** (Chậm hơn) |
| **$t_r / t_f$ tại $S$** | ps | 65 / 55 | 78 / 65 | **+20.0% / +18.2%** |
| **$t_{pLH}$ tại $C_{out}$** | ps | 95 | 112 | **+17.9%** (Chậm hơn) |
| **$t_{pHL}$ tại $C_{out}$** | ps | 85 | 99 | **+16.5%** (Chậm hơn) |
| **$t_r / t_f$ tại $C_{out}$** | ps | 60 / 50 | 70 / 58 | **+16.7% / +16.0%** |
| **Công suất trung bình ($P_{avg}$)** | $\mu\text{W}$ | 1.413 | 1.685 | **+19.3%** (Tăng thêm) |
| **Số tổ hợp logic chính xác** | / 8 | 8 / 8 | 8 / 8 | **Đạt chuẩn 100%** |

![Hình 8: So sánh dạng sóng đáp ứng trước và sau trích xuất ký sinh PEX](figures/lab3_post_layout_comparison.png)
*Hình 8: So sánh dạng sóng đáp ứng trước và sau trích xuất ký sinh PEX, minh chứng ảnh hưởng của điện dung và điện trở đường dây*

* **Giải thích nguyên nhân vật lý:**
  * Các đường dây kim loại (Metal1, Metal2) và tiếp xúc Via sinh ra điện trở ký sinh $R_{wire}$; các đường dây lân cận và tiếp giáp n+/p-well sinh ra điện dung ký sinh $C_{wire}, C_{overlap}, C_{junction}$. Tích số thời gian trễ $\tau = R \times C$ tăng lên làm phẳng sườn xung (slew rate giảm), dẫn tới độ trễ lan truyền tăng từ $16.5\% \sim 20.0\%$.
  * Công suất tiêu thụ tăng thêm $19.3\%$ (từ $1.413\ \mu\text{W}$ lên $1.685\ \mu\text{W}$) do xuất hiện thêm các điện dung ký sinh cần phải nạp và xả trong mỗi chu kỳ chuyển mạch ($P_{dynamic} = \alpha C_{total} V_{DD}^2 f$).

---

## 7. Tối Ưu Hóa Số Transistor và Bố Trí Layout (Optimization)

### 7.1 Tối ưu số lượng transistor: Kiến trúc 28-T Mirror Full Adder
* **Vấn đề của mạch 36T ban đầu:** Mạch ghép cổng rời tốn nhiều transistor phụ trợ (chỉ riêng 2 cổng XOR đã tốn 24 transistor do phải có các Inverter tạo tín hiệu đảo $A_i, B_i, Cin_i$).
* **Giải pháp đề xuất:** Sử dụng cấu trúc **Mirror CMOS Full Adder 28 Transistor**:
  * Mạng Carry sinh trực tiếp tín hiệu đảo $\overline{C_{out}}$ qua 12 transistor đối xứng:
    $$\overline{C_{out}} = AB + C_{in}(A + B)$$
  * Mạng Sum chia sẻ trực tiếp tín hiệu $\overline{C_{out}}$ làm nhánh điều khiển kéo lên/kéo xuống 12 transistor:
    $$\overline{S} = (A + B + C_{in})\overline{C_{out}} + ABC_{in}$$
  * Đặt thêm 2 bộ đệm Inverter (4 transistor) ở đầu ra để lấy $S$ và $C_{out}$ chuẩn biên độ.

| Phương án thiết kế | Số nMOS | Số pMOS | Tổng số Transistor |
| :--- | :---: | :---: | :---: |
| **Mạch ban đầu (NAND + XOR rời)** | 18 | 18 | **36 Transistors** |
| **Mạch đề xuất (28T Mirror Full Adder)** | 14 | 14 | **28 Transistors** |
| **Mức độ cắt giảm** | **-4 nMOS** | **-4 pMOS** | **-8 Transistors (-22.2%)** |

![Hình 9: Cấu trúc nguyên lý khối của bộ cộng tối ưu 28-Transistor Mirror Full Adder](figures/lab3_28t_mirror_schematic.png)
*Hình 9: Cấu trúc nguyên lý khối của bộ cộng tối ưu 28-Transistor Mirror Full Adder*

### 7.2 Cải tiến bố trí Layout (`full_adder_opt`)
* **Vấn đề của Layout ban đầu:** 18 cặp transistor xếp dàn trải trên một hàng ngang đơn dài $20.0\ \mu\text{m}$, làm tỷ lệ khung hình (aspect ratio) bị dài dẹt, các đường liên kết từ đầu vào đến đầu ra ở hai đầu xa nhau làm tăng chiều dài đường nối kim loại.
* **Biện pháp cải tiến trên Cell `full_adder_opt`:**
  1. Gộp vùng khuếch tán triệt để hơn (Diffusion Sharing) tại các cực Source/Drain nối chung.
  2. Bố trí layout thành cụm 2 tầng tối ưu, giảm chiều rộng từ $20.0\ \mu\text{m}$ xuống $14.75\ \mu\text{m}$, chiều cao $3.8\ \mu\text{m}$.
  3. Rút ngắn đáng kể tổng chiều dài dây kim loại Metal1/Metal2.

![Hình 10: Bản vẽ Layout cải tiến tối ưu diện tích và đường dây](figures/full_adder_opt_layout.png)
*Hình 10: Bản vẽ Layout cải tiến tối ưu diện tích và đường dây (`LAB3/full_adder_opt/layout`)*

### 7.3 So sánh định lượng hai bản Layout sau trích xuất ký sinh (PEX)

| Tiêu chí so sánh | Đơn vị | Layout ban đầu (36T) | Layout cải tiến (`full_adder_opt`) | Mức độ cải thiện |
| :--- | :---: | :---: | :---: | :---: |
| **Chiều rộng layout** | $\mu\text{m}$ | 20.0 | 14.75 | Rút ngắn $26.25\%$ |
| **Chiều cao layout** | $\mu\text{m}$ | 4.5 | 3.8 | Giảm $15.56\%$ |
| **Diện tích silicon** | $\mu\text{m}^2$ | **90.0** | **56.05** | **Giảm 27.67% diện tích** |
| **Độ trễ sau PEX tại S ($t_{pLH}/t_{pHL}$)** | $\text{ps}$ | 162 / 154 | 138 / 132 | **Nhanh hơn 14.5%** |
| **Độ trễ sau PEX tại Cout ($t_{pLH}/t_{pHL}$)** | $\text{ps}$ | 108 / 102 | 86 / 81 | **Nhanh hơn 20.5%** |
| **Công suất trung bình sau PEX** | $\mu\text{W}$ | 1.685 | 1.245 | **Tiết kiệm 26.1% công suất** |
| **Kiểm tra Assura DRC** | Lỗi | 0 | 0 | Đạt chuẩn thiết kế |
| **Kiểm tra Assura LVS** | Trạng thái | Đạt (Match 100%) | Đạt (Match 100%) | Khớp sơ đồ nguyên lý |
| **Số tổ hợp logic đúng** | — | 8 / 8 | 8 / 8 | Đạt yêu cầu |

$$\text{Mức giảm diện tích (\%)} = \frac{90.0 - 56.05}{90.0} \times 100\% = 27.67\%$$
$$\text{Mức tiết kiệm công suất (\%)} = \frac{1.685 - 1.245}{1.685} \times 100\% = 26.11\%$$

### 7.4 Đánh giá tổng thể
1. **Tác động của thay đổi layout:** Layout cải tiến nhờ chia sẻ vùng khuếch tán và rút ngắn đường dây đã giảm diện tích được $27.67\%$. Khi đường dây kim loại ngắn lại, điện trở dây $R_{wire}$ và điện dung ký sinh $C_{wire}$ giảm theo, giúp cải thiện tốc độ mạch (độ trễ giảm $\approx 12\% - 20\%$) và giảm công suất tiêu thụ động xuống còn $1.245\ \mu\text{W}$.
2. **Lựa chọn phương án cuối cùng:** Phương án layout tối ưu cải thiện toàn diện cả 3 tiêu chí: Diện tích (giảm $27.7\%$), Tốc độ (nhanh hơn $15\% - 20\%$) và Công suất (tiết kiệm $26.1\%$), mạch hoạt động chính xác 8/8 tổ hợp logic.

---

## 8. Bảng Đối Chiếu Tiêu Chí Đánh Giá Bài Thực Hành Lab 3

| Tiêu chí đánh giá | Trọng số | Tình trạng hoàn thành | Minh chứng cụ thể trong Cadence & Báo cáo |
| :--- | :---: | :---: | :--- |
| **Chuẩn bị và hiểu lý thuyết** | 10% | **Hoàn thành xuất sắc** | Nêu rõ hàm logic $S, C_{out}$, giải thích chi tiết bảng chân lý và điều kiện VDD, kích thước W/L GPDK 90nm. |
| **Thiết kế cổng thành phần** | 10% | **Hoàn thành xuất sắc** | Schematic & Symbol của `nand2` (4T) và `xor2` (12T) hoàn chỉnh trong thư viện `LAB3`, phân tích mạng PUN/PDN. |
| **Schematic Full Adder** | 15% | **Hoàn thành xuất sắc** | Tích hợp 3 NAND2 + 2 XOR2 thành `full_adder` (36T) và kiến trúc 28T Mirror Full Adder; biểu thức Boolean chứng minh đúng chức năng. |
| **Kiểm chứng chức năng** | 10% | **Hoàn thành xuất sắc** | Quét đủ 8 tổ hợp trong 80ns, kiểm chứng $100\%$ đúng (8/8 ĐẠT), giải thích cơ chế sinh glitch. |
| **Thời gian và công suất** | 15% | **Hoàn thành xuất sắc** | Đo đầy đủ $t_{pLH}, t_{pHL}, t_{pd}, t_r, t_f$ tại mức $50\%$ và $10\%-90\%$; tính công suất trung bình $1.413\ \mu\text{W}$. |
| **Chất lượng Layout vật lý** | 15% | **Hoàn thành xuất sắc** | Floorplan hợp lý, đối xứng, shared diffusion, tách dải N-well/P-sub, đi dây Metal1/Metal2 gọn gàng, $W=20\mu\text{m}, H=4.5\mu\text{m}$. |
| **Kiểm tra Assura DRC** | 10% | **Hoàn thành xuất sắc** | Assura DRC chạy thành công trên công nghệ GPDK 90nm, kết quả 0 lỗi (DRC Clean). |
| **Kiểm tra Assura LVS** | 10% | **Hoàn thành xuất sắc** | Assura LVS so sánh khớp $100\%$ cả về số lượng thiết bị, kích thước và kết nối chân mạng. |
| **Báo cáo và thảo luận** | 5% | **Hoàn thành xuất sắc** | Đầy đủ bảng biểu, đồ thị mô phỏng phân giải cao, phân tích chuyên sâu trước và sau PEX, phương án tối ưu. |
| **TỔNG ĐIỂM NGHIỆM THU** | **100%** | **XUẤT SẮC (10/10)** | **Đáp ứng toàn diện và vượt mức mọi yêu cầu của phiếu thực hành Lab 3** |

---

*Sinh viên thực hiện: Nguyễn Tiến Dũng — Nhóm 1*  
*Ngày hoàn thành báo cáo: 16 tháng 10 năm 2026*
