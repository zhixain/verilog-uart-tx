# UART TX Module (Verilog)

## 專案說明
使用 Verilog 實作 UART 傳送端(TX)模組，採用 FSM(有限狀態機)架構設計，
支援 8-bit 資料傳輸，格式為：1 start bit + 8 data bits(LSB first) + 1 stop bit。

## FSM 狀態圖
| 狀態  | tx 輸出        | busy | 說明             |
|-------|----------------|------|------------------|
| IDLE  | 1              | 0    | 閒置等待         |
| START | 0              | 1    | 發送 start bit   |
| DATA  | data[bit_cnt]  | 1    | 依序發送 8 個 bit|
| STOP  | 1              | 1    | 發送 stop bit    |

## 模組介面
| 訊號  | 方向   | 說明                  |
|-------|--------|-----------------------|
| clk   | input  | 系統時脈              |
| rst   | input  | 非同步重置(active high)|
| start | input  | 啟動傳輸              |
| data  | input  | 8-bit 待傳資料        |
| tx    | output | 序列輸出              |
| busy  | output | 傳輸中旗標            |

## 模擬波形
(waveform.png)

波形驗證：
- 0x55(01010101) 與 0xA3 兩筆資料傳輸正確
- start bit、8個data bit(LSB first)、stop bit 順序正確
- busy 信號在傳輸期間正確拉高

## 開發工具
- Verilog HDL
- EDA Playground + Icarus Verilog
- EPWave 波形檢視
