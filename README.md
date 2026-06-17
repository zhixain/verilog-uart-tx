# UART TX Module (Verilog)

## 專案說明
使用 Verilog 實作 UART 傳送端(TX)模組，採用 FSM(有限狀態機)架構設計，
支援 8-bit 資料傳輸，格式為：1 start bit + 8 data bits(LSB first) + 1 stop bit。

## FSM 狀態圖
