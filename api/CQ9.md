CQ9
=========================
0. **注意**
	- 需支援 zh-tw、zh-cn、en 任一語言
	- 正式環境需封鎖台灣 IP, 加入 CQ9 IP 到白名單
0. **遊戲網址**
	- {遊戲伺服器網址}/{遊戲ID}/?token={gametoken}&language={zh-cn/en}
0. **細單網址**
	- 細單扣除當月需保留三個月以上
	- {細單網頁網址}?token={DetailToken}&language={zh-cn/en}
0. **重送、退款**
	- 若下注結果 (Bet/Rollout) 未知時, 需要執行 (Refund/Rollin) 確認沒有多扣除款項
	- 若 (Endround/Rollin) 未成功的話, 需要重送 (Endround/Rollin) 至成功為止
	- 若本身沒有相對機制, 可使用 Round-Check 了解實作項目
	- 每個小時確認所有沒有完成的單據, 進行完成或是退款的動作
0. **維護**
	- 維護時, 提前通知 CQ9
	- 維護開始前, 踢除在線玩家
0. **接入輔助**
	- peace/gametoken
		- 創建 gametoken
	- peace/detailtoken
		- 創建 detailtoken
	- peace/money/in
		- 存款
	- peace/money/out
		- 提款
0. **API 格式**
	- 時間為 UTC-4, RFC3339, 帶毫秒
	- 遊戲代碼為團隊代碼+英數字, 如 BN08
	- roundid 遊戲回合編號, 為團隊代碼+英數字 (長度 30), 如 BNT00039
	- mtcode 交易代碼, 為 {env}-{action}-{roundid}, 如 rel-bet-BNT00039
0. **API 注意**
	- 關閉視窗時需登出
	- 閒置 10 分鐘要剔除玩家
	- 若為 slot, arcade 類型遊戲, 建議每 3~5 秒呼叫 Balance 來顯示介面餘額
	- 若為 fish, table 類型遊戲, 且沒有使用 takeall 來轉入額度到遊戲中, 建議每 3~5 秒呼叫 Balance 來獲取餘額, 並與預先轉入的額度做相加顯示介面餘額
0. **user API**
	- gamepool/cq9/player/auth
		- 驗證 Game Token, 回傳玩家資訊
	- gamepool/cq9/player/balance/{id}
		- 查詢餘額
	- gamepool/cq9/player/logout
		- 登出
0. **slot/arcade API**
	- gamepool/cq9/game/bet
		- 下注
	- gamepool/cq9/game/win
		- 贏分
	- gamepool/cq9/game/end
		- 結算
0. **refund API**
	- gamepool/cq9/game/roundcheck
		- 查詢未完成注單
		- indexid string: 訂單索引, roundid:cq9, 如 "BNT00039:cq9"
		- 09:00 時, 需要撈取 07:00~08:00 此區間未成單的單據做補單、退款
		- 有 bet complete, 沒有 win 的資料 -> refund (server crash 處理)
		- 有 bet complete 且 win init, DB 有資料 -> endround
	- gamepool/cq9/game/rounddetail
		- 取得注單狀態
		- 此處的 mtcode 會有 :cq9 後綴, 如 rel-bet-BNT00039:cq9
	- gamepool/cq9/game/generateroundcache
		- game/end game token 失效時, 重新激活
	- gamepool/cq9/game/bet/refund
		- 下注取消
	- gamepool/cq9/game/win/cancel
		- 贏分取消
0. **game result API**
	- gamepool/cq9/game/detailtoken
		- 驗證與解析細單 Token
	- gamepool/cq9/game/getorder
		- 取得注單資訊
0. **例外 API**
	- gamepool/cq9/order/debit
		- 注單補扣款
	- gamepool/cq9/order/credit
		- 注單補款
0. **資訊 API**
	- gamepool/cq9/game/currency
		- 幣別列表
0. **其他 API**
	- gamepool/cq9/game/playerorder
		- 注單網址