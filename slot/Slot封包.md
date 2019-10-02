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
		- FGRetriggerAwardTimes int   // FG retrigger 額外增加的次數
0. **Base Game Spin**
	- CtoGSlotNGPlay
		- Code int // 11002
		- BetMultiple int // 押注乘數
	- SSlotWinLineInfo
		- LineNo      int   // 線號; line game: 線號, way game: 0, 997: scatter, 998: bonus, 999: free game
		- SymbolID    int   // 中獎 symbol id
		- SymbolCount int   // symbol 連線數
		- WayeCount   int   // way game 使用的連線數
		- WinPosition []int // 贏分位置索引的列表: row-major, 左上到右下順序, 依序為 1~15
		- Multiplier  int   // 倍數
		- Win         int64 // 贏分
		- PayRate     int   // 賠率
	- SSlotLDOptions
		- Multipliers   []int   // 倍數選項列表 (暗選時前端需自己打亂)
		- FGTimes       []int64 // FG 次數選項列表 (暗選時前端需自己打亂)
		- MultiplierSelected int // 選中的倍數選項 (暗選會用到)
		- FGTimesSelected int	// 選中的 FG 次數 (暗選會用到)
	- GtoCSlotNGPlay
		- Code int // 11003
		- Result       int                // 結果 (錯誤碼)
		- RoundID      int64              // 局 ID
		- WinType      int                // 中獎類型; 0: none, 11: 一般贏分, 21: bonus game, 31: free game
		- Multiplier   int                // 倍數
		- SymbolResult []int              // symbol id 盤面: row-major, 左上到右下順序
		- WinLineInfos []SSlotWinLineInfo // 贏線資訊列表
		- LDOptions    []SSlotLDOptions   // LD 選項列表
0. **Bonus Game Start(略)**
	- CtoGSlotBGStart
		- Code int // 11004
	- GtoCSlotBGStart
		- Code int // 11005
		- Result       int // 結果 (錯誤碼)
		- BGTotalTimes int // BG 總次數
0. **Bonus Game Play**
	- CtoGSlotBGPlay
		- Code int // 11006
		- (略)
		- SelectedIndex int // 選取的索引
	- SSlotBGPlayInfo
		- Multipliers        []int   // 倍數選項列表
		- WinOptions         []int64 // 贏分選項列表
		- MultiplierSelected int     // 選中的倍數選項
		- WinOptionSelected  int64   // 選中的贏分選項
		- Win                int64   // 贏分
	- GtoCSlotBGPlay
		- Code int // 11007
		- Result      int               // 結果 (錯誤碼)
		- BGPlayInfos []SSlotBGPlayInfo // BG 選項資訊列表
0. **Bonus Game End(略)**
	- CtoGSlotBGEnd
		- Code int // 11008
	- GtoCSlotBGEnd
		- Code int // 11009
		- Result        int     // 結果 (錯誤碼)
0. **Lucky Draw Start(略)**
	- CtoGSlotLDStart
		- Code int // 11010
	- GtoCSlotLDStart
		- Code int // 11011
		- Result       int // 結果 (錯誤碼)
		- LDTotalTimes int // LD 總次數
0. **Lucky Draw Play**
	- CtoGSlotLDPlay
		- Code int // 11012
		- SelectedIndice []int // 選取的索引列表 (明選會用到)
	- GtoCSlotLDPlay
		- Code int // 11013
		- Result        int     // 結果 (錯誤碼)
		- (略)
		- SelectedIndex int     // 選取的索引
		- Multipliers   []int   // 倍數選項列表
		- FGTimes       []int64 // FG 次數選項列表
0. **Lucky Draw End(略)**
	- CtoGSlotLDEnd
		- Code int // 11014
	- GtoCSlotLDEnd
		- Code int // 11015
		- Result        int     // 結果 (錯誤碼)
0. **Free Game Start(略)**
	- CtoGSlotFGStart
		- Code int // 11016
	- GtoCSlotFGStart
		- Code int // 11017
		- Result         int // 結果 (錯誤碼)
		- FGTotalTimes   int // FG 總次數; 前端內部 retrigger 請自行判斷上限為此
		- Multiplier     int // 倍數
0. **Free Game Play**
	- CtoGSlotFGPlay
		- Code int // 11018
	- SSlotFGSpinInfo
		- WinType      int                // 中獎類型; 0: none, 11: 一般贏分, 21: bonus game, 31: free game
		- SymbolResult []int              // symbol id 盤面: row-major, 左上到右下順序
		- WinLineInfos []SSlotWinLineInfo // 贏線資訊列表
	- GtoCSlotFGPlay
		- Code int // 11019
		- Result       int                // 結果 (錯誤碼)
		- FGTotalTimes int               // FG 總次數; 前端內部 retrigger 請自行判斷上限為此
		- Multiplier   int               // 倍數
		- FGSpinInfos  []SSlotFGSpinInfo // FG Spin 資訊列表
0. **Free Game End(略)**
	- CtoGSlotFGEnd
		- Code int // 11020
	- GtoCSlotFGEnd
		- Code int // 11021
		- Result int // 結果 (錯誤碼)
0. **Round End**
	- 局結束, 後端此時錢才真的記入 DB
	- CtoGSlotRoundEnd
		- Code int // 11022
	- GtoCSlotRoundEnd
		- Code int // 11023
		- Result int   // 結果 (錯誤碼)
		- Money  int64 // 金額
0. **問題**
	- 閒置踢除由 server 判定嗎