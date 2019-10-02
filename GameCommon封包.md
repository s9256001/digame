Game Common 封包
=========================
0. **遊戲錯誤**
	- GtoCGameError
		- Code int // 1001
		- ErrorReason int // 錯誤原因
0. **加入遊戲**
	- CtoGJoinGame
		- Code int // 1002
		- GameToken string // 遊戲 token
		- GameID    int    // 客端對應的遊戲 ID; 防止 GameToken 貼在不同遊戲網頁的錯誤
		- 若 Server 比對 GameID 不合, 將會切斷連線並回傳加入遊戲錯誤
	- GtoCJoinGame
		- Code int // 1005
		- GameToken string // 遊戲 token
		- Result    int    // 結果
		- GameID    int    // 遊戲 ID
		- AccountID uint32 // 帳號 ID
		- Account   string // 帳號
		- Money     int64  // 金額
0. **離開遊戲**
	- CtoGLeaveGame
		- Code int // 1006
	- GtoCLeaveGame
		- Code int // 1008
		- Result int // 結果
