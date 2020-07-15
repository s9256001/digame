Fish Wallet 單一錢包
=========================
0. **個人錢包轉至遊戲錢包**
	- /game/rollin
	- 選擇漁場時觸發
	- request
		- user_name   string  // 使用者名稱
		- token       string  // 憑證
		- game_id     int     // 遊戲ID
		- amount      float64 // 轉入金額
		- take_all    bool    // 只拿整數
		- min_balance float64 // 最小帶入金額
		- order_id    string  // 交易唯一碼
	-response
		- code    int     // 回應碼
		- balance float64 // 餘額
0. **遊戲錢包轉至個人錢包**
	- /game/rollout
	- 離開漁場時觸發
	- rollout = rollin - bet + win
	- request
		- user_name string  // 使用者名稱
		- token     string  // 憑證
		- game_id   int     // 遊戲ID
		- amount    float64 // 轉出金額
		- order_id  string  // 交易唯一碼
	-response
		- code    int     // 回應碼
		- balance float64 // 餘額
0. **通知注單**
	- /game/bet_summary
	- 送失敗要 retry
	- request
		- user_name  string  // 使用者名稱
		- token      string  // 憑證
		- game_id    int     // 遊戲ID
		- round_code string  // 局號
		- bet        float64 // 押注金額
		- win        float64 // 贏分金額
		- start_time string  // 開始時間
		- end_time   string  // 結束時間
	-response
		- code int // 回應碼
