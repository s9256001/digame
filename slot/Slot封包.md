Slot 封包<span id="標題"></span>
=========================

<a href="#說明">說明</a><br />
<a href="#初始資訊">初始資訊</a><br />
<a href="#Base Game Spin">Base Game Spin</a><br />
<a href="#Bonus Game Play">Bonus Game Play</a><br />
<a href="#Lucky Draw Play">Lucky Draw Play</a><br />
<a href="#Free Game Play">Free Game Play</a><br />
<a href="#Round End">Round End</a>

0. **說明**<span id="說明"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- 由於 CQ9 要求玩家斷線, FG 必須整輪 (可能包含多場 Spin) 表演完, 所以此處 BG、LD、FG 都採用一包封包設計
0. **初始資訊**<span id="初始資訊"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- GtoCSlotInit
		- Code int // 11001
		- // GtoCJoinGame 後 Server 會直接送這封包
		- MoneyFractionMultiple int   // 錢小數轉整數時要乘的倍數: 以整數型態保存, 轉為小數需除以此欄位
		- Denom                 int   // 錢轉分數的匯率 (單位 1/100): 分數=錢/(Denom/100)=錢x(100/Denom)
		- Line                  int   // 線數; line game: 線數, way game: 1
		- BetMultiples          []int // 押注乘數列表
		- BetUnit               int64 // 押注單位; line game: 押注乘數x押注單位=每線押注, way game: 押注乘數x押注單位=總押注
0. **Base Game Spin**<span id="Base Game Spin"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotNGPlay
		- Code int // 11002
		- BetMultiple int // 押注乘數
	- SSlotWinLineInfo
		- LineNo      int   // 線號; line game: 線號, way game: 0; 997: scatter, 998: bonus, 999: free game
		- SymbolID    int   // 中獎 symbol id
		- SymbolCount int   // symbol 連續的軸數 (ex. 3 連、4 連、5 連)
		- WayeCount   int   // way game 使用的連線數 (ex. 3 symbol, 4 reel 為 81 ways)
		- WinPosition []int // 贏分位置索引的列表: 位置為 row-major, 左上到右下順序, 依序為 0~14
		- Multiplier  int   // 倍數
		- Win         int64 // 贏分
		- PayRate     int   // 賠率
	- SSlotLDOptions
		- Multipliers        []int   // 倍數選項列表 (暗選時前端需自己打亂)
		- FGTimes            []int64 // FG 次數選項列表 (暗選時前端需自己打亂)
		- MultiplierSelected int     // 選中的倍數選項 (暗選會用到)
		- FGTimesSelected    int     // 選中的 FG 次數 (暗選會用到)
	- GtoCSlotNGPlay
		- Code int // 11003
		- Result       int                // 結果 (錯誤碼)
		- RoundID      int64              // 局 ID
		- WinType      int                // 中獎類型; 0: none, 11: 一般贏分, 21: bonus game, 31: free game
		- Multiplier   int                // 倍數
		- SymbolResult []int              // symbol id 盤面: row-major, 左上到右下順序
		- WinLineInfos []SSlotWinLineInfo // 贏線資訊列表
		- FGTotalTimes int                // FG 總次數
		- LDOptions    []SSlotLDOptions   // LD 選項列表
0. **Bonus Game Play**<span id="Bonus Game Play"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotBGPlay
		- Code int // 11004
	- SSlotBGPlayInfo
		- Multipliers        []int   // 倍數選項列表
		- WinOptions         []int64 // 贏分選項列表
		- MultiplierSelected int     // 選中的倍數選項
		- WinOptionSelected  int64   // 選中的贏分選項
		- Win                int64   // 贏分
	- GtoCSlotBGPlay
		- Code int // 11005
		- Result      int               // 結果 (錯誤碼)
		- BGPlayInfos []SSlotBGPlayInfo // BG 選項資訊列表
0. **Lucky Draw Play**<span id="Lucky Draw Play"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotLDPlay
		- Code int // 11006
		- // 玩家選完, 前端表演完, 再發送此封包
		- SelectedIndexes []int // 選取的索引列表 (明選會用到)
	- GtoCSlotLDPlay
		- Code int // 11007
		- Result int // 結果 (錯誤碼)
0. **Free Game Play**<span id="Free Game Play"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotFGPlay
		- Code int // 11008
	- SSlotFGSpinInfo
		- WinType      int                // 中獎類型; 0: none, 11: 一般贏分, 21: bonus game, 31: free game
		- SymbolResult []int              // symbol id 盤面: row-major, 左上到右下順序
		- WinLineInfos []SSlotWinLineInfo // 贏線資訊列表
		- FGTotalTimes int                // FG 總次數
	- GtoCSlotFGPlay
		- Code int // 11009
		- Result      int               // 結果 (錯誤碼)
		- Multiplier  int               // 倍數
		- FGSpinInfos []SSlotFGSpinInfo // FG Spin 資訊列表
		- LDOptions   []SSlotLDOptions  // LD 選項列表
0. **Round End**<span id="Round End"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotRoundEnd
		- Code int // 11010
		- // 前端局表演完, 發送此封包, Server 判定局結束, 此時錢才真的記入 DB (CQ9 要求此時才查的到錢)
	- GtoCSlotRoundEnd
		- Code int // 11011
		- Result int   // 結果 (錯誤碼)
		- Money  int64 // 金額
