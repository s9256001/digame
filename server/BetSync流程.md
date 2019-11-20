BetSync流程
=========================
0. **Server Start**
	- 每個 queue 都用一個 channel 來實現
	- 由 DB 取得待同步的注單列表, 丟到 sync queue
0. **Round Check**
	- round check start
		- /game/roundcheck: 定時撈取前兩個小時~前一個小時的待同步注單列表
		- 新增待同步的注單列表, 更新上次注單同步時間
		- 丟到 sync queue
	- sync queue
		- /game/rounddetail: 取得營運方的注單明細
		- 撈取我方的 DB 注單狀態
		- 依照營運方與我方的注單狀態, 判斷轉發到後續處理的 queue
		
		| Operator | Game       | 處理                                |
		|----------|------------|-------------------------------------|
		| Bet      | N/A        | 加入 refund queue                   |
		| Bet      | BetSuccess | 加入 refund queue                   |
		| Win      | BetSuccess | 加入 win cancel queue               |
		| Win      | WinFailed  | 加入 win cancel queue               |
		| Win      | WinSuccess | 加入 end retry queue                |
		| End      | WinSuccess | 修改 DB log_slot_bet 注單狀態為 end |
	- refund queue
		- /game/bet/refund: 通知平台 refund
		- 標記該筆待同步的注單為完成, 注單狀態改為已補帳
	- win cancel queue
		- /game/win/cancel: 通知平台 win cancel
		- 加入 refund queue
	- end retry qeuee
		- /game/generateoneroundcache: 先激活 game token
		- /game/end: 通知平台 end
		- 標記該筆待同步的注單為完成, 注單狀態改為 end api 成功
