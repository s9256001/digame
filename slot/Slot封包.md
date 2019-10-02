Slot 封包
=========================
0. **初始資訊**
	- GtoCSlotInit
		- Code int // 11001
		- MoneyFractionMultiple int   // 錢小數轉整數時要乘的倍數: 以整數型態保存, 轉為小數需除以 MoneyFractionMultiple
		- Denom                 int   // 錢轉分數的匯率 (單位 1/100): 分數=錢/(Denom/100)=錢x(100/Denom)
		- Line                  int   // 線數; line game: 線數, way game: 1
		- BetMultiples          []int // 押注乘數列表
		- BetUnit               int64 // 押注單位; line game: 押注乘數x押注單位=每線押注, way game: 押注乘數x押注單位=總押注
0. **Base Game Spin**
	- CtoGSlotNGPlay
		- Code int // 11002
		- BetMultiple int // 押注乘數
	- SSlotWinLineInfo
		- LineNo      int   // 線號; line game: 線號, way game: 0, 997: scatter, 998: bonus, 999: free game
		- WinType     int   // ?贏分類型 0：一般贏分(左線中獎), 1：進入FreeGame(ReTrigger), 2：右線中獎?
		- SymbolID    int   // 中獎 symbol id
		- SymbolCount int   // symbol 連線數
		- LineCount   int   // way game 使用的連線數
		- WinPosition []int // 贏分位置: row-major, 左上到右下順序
		- Multiplier  int   // 倍數
		- Win         int64 // 贏分
	- GtoCSlotNGPlay
		- Code int // 11003
		- Result       int                // 結果
		- RoundID      int64              // 局 ID
		- WinType      int                // 中獎類型; 0: none, 11: 一般贏分, 21: bonus game, 31: free game
		- Multiplier   int                // 倍數
		- Money        int64              // 金額
		- SymbolResult []int              // symbol id 盤面: row-major, 左上到右下順序
		- WinLines     []SSlotWinLineInfo // 贏線資訊列表
0. **Bonus Game Start**
	- CtoGSlotBGStart
		- Code int // 11004
	- GtoCSlotBGStart
		- Code int // 11005
		- Result       int // 結果
		- BGTotalTimes int // BG 總次數
0. **Bonus Game Play**
	- CtoGSlotBGPlay
		- Code int // 11006
		- SelectedIndex int // 選取的索引
	- GtoCSlotBGPlay
		- Code int // 11007
		- Result        int     // 結果
		- SelectedIndex int     // 選取的索引
		- Multipliers   []int   // 倍數選項列表
		- Wins          []int64 // 贏分選項列表
		- Money         int64   // 金額
		- Win           int64   // 贏分
0. **Bonus Game End**
	- CtoGSlotBGEnd
		- Code int // 11008
	- GtoCSlotBGEnd
		- Code int // 11009
		- Result        int     // 結果
0. **Lucky Draw Start**
	- CtoGSlotLDStart
		- Code int // 11010
	- GtoCSlotLDStart
		- Code int // 11011
		- Result       int // 結果
		- LDTotalTimes int // LD 總次數
0. **Lucky Draw Play**
	- CtoGSlotLDPlay
		- Code int // 11012
		- SelectedIndex int // 選取的索引
	- GtoCSlotLDPlay
		- Code int // 11013
		- Result        int     // 結果
		- SelectedIndex int     // 選取的索引
		- Multipliers   []int   // 倍數選項列表
		- FGTimes       []int64 // FG 次數選項列表
0. **Lucky Draw End**
	- CtoGSlotLDEnd
		- Code int // 11014
	- GtoCSlotLDEnd
		- Code int // 11015
		- Result        int     // 結果
0. **Free Game Start**
	- CtoGSlotFGStart
		- Code int // 11016
	- GtoCSlotFGStart
		- Code int // 11017
		- Result         int // 結果
		- FGTimes        int // FG 目前次數
		- FGTotalTimes   int // FG 總次數
		- FGTimesAwarded int // FG 額外增加次數
		- Multiplier     int // 倍數
0. **Free Game Spin**
	- CtoGSlotFGPlay
		- Code int // 11018
	- GtoCSlotFGPlay
		- Code int // 11019
		- Result       int                // 結果
		- WinType      int                // 中獎類型; 0: none, 11: 一般贏分, 21: bonus game, 31: free game
		- Money        int64              // 金額
		- SymbolResult []int              // symbol id 盤面: row-major, 左上到右下順序
		- WinLines     []SSlotWinLineInfo // 贏線資訊列表
0. **Free Game End**
	- CtoGSlotFGEnd
		- Code int // 11020
	- GtoCSlotFGEnd
		- Code int // 11021
		- Result int // 結果