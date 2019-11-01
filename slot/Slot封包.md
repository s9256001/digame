Slot 封包<span id="標題"></span>
=========================

<a href="#說明">說明</a><br />
<a href="#初始資訊">初始資訊</a><br />
<a href="#Base Game Spin">Base Game Spin</a><br />
<a href="#Bonus Game Play">Bonus Game Play</a><br />
<a href="#Lucky Draw Play">Lucky Draw Play</a><br />
<a href="#Free Game Play">Free Game Play</a><br />
<a href="#Round End">Round End</a><br />
<a href="#列舉">列舉</a>

0. **說明**<span id="說明"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- 由於 CQ9 要求玩家斷線, FG 必須整輪 (可能包含多場 Spin) 表演完, 所以此處 BG、LD、FG 都採用一包封包設計
0. **初始資訊**<span id="初始資訊"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- GtoCSlotInit
		- Code int
		- // GtoCJoinGame 後 Server 會直接送這封包
		- MoneyFractionMultiple int   // 錢小數轉整數時要乘的倍數: 以整數型態保存, 轉為小數需除以此欄位
		- Denom                 int   // 錢轉分數的匯率 (單位 1/100): 分數=錢/(Denom/100)=錢x(100/Denom)
		- Line                  int   // 線數; line game: 線數, way game: 1
		- BetMultiples          []int // 押注乘數列表
		- BetUnit               int64 // 押注單位 (錢); line game: 押注乘數x押注單位=每線押注, way game: 押注乘數x押注單位=總押注
0. **Base Game Spin**<span id="Base Game Spin"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotNGPlay
		- Code int
		- BetMultiple int // 押注乘數
	- SSlotWinLineInfo
		- LineNo      uint8     // 線號 (1-based); line game 用
		- SymbolID    uint8     // <a href="#圖標編號">圖標編號</a>
		- SymbolType  uint8     // <a href="#圖標類型">圖標類型</a>
		- SymbolCount uint8     // symbol 連續的軸數 (ex. 3 連、4 連、5 連)
		- WayCount    uint64    // way game 使用的連線數 (ex. 3 symbol, 4 reel 為 81 ways)
		- WinPosition [][]int   // 贏分位置索引的列表; 位置索引由 [x, y] 表示, x 為第幾軸, y 為由上到下第幾格
		- Multiplier  uint64    // 線倍數
		- WinOrg      uint64    // 未乘線倍數之前的贏分 (錢)
		- Win         uint64    // 贏分 (錢)
		- WinType     uint8     // <a href="#中獎類型">中獎類型</a>
		- Odds        uint64    // 賠率
	- SSlotSpinInfo
		- WinType        uint8              // <a href="#中獎類型">中獎類型</a>
		- Multiplier     uint64             // 倍數
		- SymbolResult   [][]int            // symbol id 盤面; 第一維為由左到右第幾軸, 第二維為一軸由上到下第幾格
		- WinLineInfos   []SSlotWinLineInfo // 贏線資訊列表
		- FGTotalTimes   uint8              // FG 總次數
		- FGCurrentTimes uint8              // FG 目前次數
		- FGRemainTimes  uint8              // FG 剩餘次數
		- Win            int64              // 贏分 (錢)
	- SSlotOptionValue
		- OptionValueType uint8    // 選項值的類型
		- SelectedValue   int      // 選到的值 (暗選會用到)
		- OtherValues     []int    // 其他的值列表 (暗選時前端需自己打亂)
	- GtoCSlotNGPlay
		- Code int
		- Result    int                  // 結果 (錯誤碼)
		- RoundID   uint64               // 局 ID
		- SpinInfo  SSlotSpinInfo        // Spin 資訊
		- LDOptions [][]SSlotOptionValue // LD 選項列表; 第一維為第幾次選擇, 一次選擇內可以選出多個複合值的組合
	- 錯誤碼
		- 0: Success
		- 1: Failed
		- 2: InvalidRoomState
		- 3: InvalidBetMultiple
0. **Bonus Game Play**<span id="Bonus Game Play"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotBGPlay
		- Code int
	- GtoCSlotBGPlay
		- Code int
		- Result    int                  // 結果 (錯誤碼)
		- BGOptions [][]SSlotOptionValue // BG 選項列表; 第一維為第幾次選擇, 一次選擇內可以選出多個複合值的組合
		- Wins      []int64              // BG 贏分列表 (錢)
	- 錯誤碼
		- 0: Success
		- 1: Failed
		- 2: InvalidRoomState
0. **Lucky Draw Play**<span id="Lucky Draw Play"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotLDPlay
		- Code int
		- // 玩家選完, 前端表演完, 再發送此封包
		- SelectedIndexes []int // 選取的索引列表 (明選會用到)
	- GtoCSlotLDPlay
		- Code int
		- Result int // 結果 (錯誤碼)
	- 錯誤碼
		- 0: Success
		- 1: Failed
		- 2: InvalidRoomState
0. **Free Game Play**<span id="Free Game Play"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotFGPlay
		- Code int
	- GtoCSlotFGPlay
		- Code int
		- Result    int                  // 結果 (錯誤碼)
		- SpinInfos []SSlotSpinInfo      // Spin 資訊列表
		- LDOptions [][]SSlotOptionValue // LD 選項列表; 第一維為第幾次選擇, 一次選擇內可以選出多個複合值的組合
	- 錯誤碼
		- 0: Success
		- 1: Failed
		- 2: InvalidRoomState
0. **Round End**<span id="Round End"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- CtoGSlotRoundEnd
		- Code int
		- // 前端局表演完, 發送此封包, Server 判定局結束, 此時錢才真的記入 DB (CQ9 要求此時才查的到錢)
	- GtoCSlotRoundEnd
		- Code int
		- Result  int   // 結果 (錯誤碼)
		- Balance int64 // 金額 (錢)
	- 錯誤碼
		- 0: Success
		- 1: Failed
		- 2: InvalidRoomState
0. **列舉**<span id="列舉"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
	- 封包編號<span id="封包編號"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
		- GtoCSlotInit     = 11001
		- CtoGSlotNGPlay   = 11002
		- GtoCSlotNGPlay   = 11003
		- CtoGSlotBGPlay   = 11004
		- GtoCSlotBGPlay   = 11005
		- CtoGSlotLDPlay   = 11006
		- GtoCSlotLDPlay   = 11007
		- CtoGSlotFGPlay   = 11008
		- GtoCSlotFGPlay   = 11009
		- CtoGSlotRoundEnd = 11010
		- GtoCSlotRoundEnd = 11011
	- 圖標編號<span id="圖標編號"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
		- 空
			- SN_XX SymbolNo = 0
		- 高分圖標
			- SN_H1 SymbolNo = 1
			- SN_H2 SymbolNo = 2
			- SN_H3 SymbolNo = 3
			- SN_H4 SymbolNo = 4
			- SN_H5 SymbolNo = 5
			- SN_H6 SymbolNo = 6
			- SN_H7 SymbolNo = 7
			- SN_H8 SymbolNo = 8
			- SN_H9 SymbolNo = 9
		- 低分圖標
			- SN_N1 SymbolNo = 11
			- SN_N2 SymbolNo = 12
			- SN_N3 SymbolNo = 13
			- SN_N4 SymbolNo = 14
			- SN_N5 SymbolNo = 15
			- SN_N6 SymbolNo = 16
			- SN_N7 SymbolNo = 17
			- SN_N8 SymbolNo = 18
			- SN_N9 SymbolNo = 19
		- 百搭
			- SN_WD SymbolNo = 21
		- 免費遊戲
			- SN_FG SymbolNo = 31
		- 紅利遊戲
			- SN_BG SymbolNo = 41
		- Scatter
			- SN_SC SymbolNo = 51
		- 混合圖標
			- SN_WF SymbolNo = 91 // WD+FG
	- 圖標類型<span id="圖標類型"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
		- ST_NONE   SymbolType = 0x00
		- ST_NORMAL SymbolType = 0x01
		- ST_WD     SymbolType = 0x02
		- ST_FG     SymbolType = 0x04
		- ST_BG     SymbolType = 0x08
		- ST_SC     SymbolType = 0x10
	- 中獎類型<span id="中獎類型"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
		- WT_NONE        WinType = 0x00 // 無獎
		- WT_NORMAL      WinType = 0x01 // 一般給分
		- WT_FREEGAME    WinType = 0x02 // 中FreeGame
		- WT_BONUSGAME   WinType = 0x04 // 中BonusGame
		- WT_FEATUREGAME WinType = 0x08 // 其他特殊獎勵