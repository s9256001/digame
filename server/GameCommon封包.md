Game Common 封包
=========================
0. **心跳包**
	- // 請每 10 秒 ping 一次 server, 超過 30 秒未收到 ping 視為斷線
	- // server 收到 ping 後, 會回給 client pong 封包
	- CtoGPing
		- Code int
	- GtoCPong
		- Code int
0. **遊戲錯誤**
	- GtoCGameError
		- Code int
		- ErrorReason int // 錯誤原因
	- 錯誤原因
		- 0: None
		- 1: IdleForceClose
0. **加入遊戲**
	- CtoGJoinGame
		- Code int
		- GameToken string // 遊戲 token; Demo 不會用到此欄位
		- GameID    int    // 客端對應的遊戲 ID; 防止 GameToken 貼在不同遊戲網頁的錯誤
		- DemoOn    bool   // 是否開啟 demo 腳本模式
		- // 若 Server 比對 GameID 不合, 將回傳加入遊戲錯誤並切斷連線
	- GtoCJoinGame
		- Code int
		- GameToken string // 遊戲 token
		- GameID    int    // 遊戲 ID
		- DemoOn    bool   // 是否開啟 demo 腳本模式
		- Result    int    // 結果 (錯誤碼)
		- AccountID uint32 // 帳號 ID
		- Balance   int64  // 金額 (錢)
	- 錯誤碼
		- 0: Success
		- 1: Failed
		- 2: NotReady
		- 3: MismatchGameCode
		- 4: GameDisabled
0. **離開遊戲**
	- CtoGLeaveGame
		- Code int
	- GtoCLeaveGame
		- Code int
		- Result int // 結果 (錯誤碼)
	- 錯誤碼
		- 0: Success
		- 1: Failed
0. **更新餘額**
	- GtoCPlayerBalance
		- Code int
		- Balance int64 // 金額 (錢)
0. **更新彩金**
	- SJPView<span id="彩金檢視資訊"></span>
		- JPLevel int   // <a href="#彩金層級">彩金層級</a>
		- Value   int64 // 彩金現值 (錢)
	- GtoCJackpotValue
		- Code int
		- JPViews []SJPView // 彩金檢視資訊列表
0. **列舉**
	- 封包編號
		- CtoGPing          = -1
		- GtoCPong          = -2
		- GtoCGameError     = 1001
		- CtoGJoinGame      = 1002
		- GtoCJoinGame      = 1005
		- CtoGLeaveGame     = 1006
		- GtoCLeaveGame     = 1008
		- GtoCPlayerBalance = 1011
		- GtoCJackpotValue  = 1013
	- 彩金層級<span id="彩金層級"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
		- JPLevelGrand = 1
		- JPLevelMajor = 2
		- JPLevelMinor = 3
		- JPLevelMini  = 4
	- 幣別<span id="幣別"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>
		- CNY = 1
		- VND = 2