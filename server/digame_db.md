# Schema documentation<span id="標題"></span>

<a href="#account">account</a><br />
<a href="#balance_history">balance_history</a><br />
<a href="#bet_sync">bet_sync</a><br />
<a href="#currency">currency</a><br />
<a href="#game">game</a><br />
<a href="#game_class">game_class</a><br />
<a href="#game_type">game_type</a><br />
<a href="#log_api">log_api</a><br />
<a href="#log_error">log_error</a><br />
<a href="#log_login">log_login</a><br />
<a href="#log_logout">log_logout</a><br />
<a href="#log_order">log_order</a><br />
<a href="#log_slot_bet">log_slot_bet</a><br />
<a href="#log_slot_bet_detail">log_slot_bet_detail</a><br />
<a href="#operator">operator</a><br />
<a href="#system_value">system_value</a><br />

## Table: `account`<span id="account"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

帳號

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | INT | PRIMARY, Not null |   | 帳號ID |
| `operator_id` | INT | Not null |   | 營運商ID |
| `user_name` | VARCHAR(255) | Not null |   | 使用者名稱 |
| `balance` | BIGINT | Not null |   | 餘額 |
| `currency_id` | INT | Not null |   | 貨幣ID |
| `status` | TINYINT | Not null |   | 狀態<br />1: 正常<br />2: 凍結<br />3: 停用 |
| `create_time` | BIGINT | Not null |   | 建立時間 |
| `update_time` | BIGINT | Not null |   | 最近一次的修改時間 |
| `is_deleted` | SMALLINT | Not null |   | 邏輯刪除 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |


## Table: `balance_history`<span id="balance_history"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

餘額異動歷史

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | BIGINT | PRIMARY, Auto increments, Not null |   | 流水號 |
| `account_id` | INT | Not null |   | 帳號ID |
| `operator_id` | INT | Not null |   | 營運商ID |
| `amount` | BIGINT | Not null |   | 異動金額的數量 |
| `balance` | BIGINT | Not null |   | 操作完後的餘額 |
| `create_time` | BIGINT | Not null |   | 建立時間 |
| `table_name` | VARCHAR(45) | Not null |   | table名稱<br />紀錄關聯的table名稱 |
| `table_id` | BIGINT | Not null |   | table row id<br />紀錄關聯的table對應資料列的ID |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |


## Table: `bet_sync`<span id="bet_sync"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

cq9待同步注單的資料

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `index_id` | VARCHAR(255) | PRIMARY, Not null |   | 訂單索引 |
| `mtcode` | VARCHAR(255) | Not null |   | 交易代碼 |
| `round_code` | VARCHAR(255) | Not null |   | 局號 |
| `round_id` | BIGINT | Not null |   | 局ID |
| `status` | INT | Not null |   | 注單狀態<br />0: 待sync<br />1: 處理完畢 |
| `create_time` | BIGINT | Not null |   | 建立時間 |
| `done_time` | BIGINT | Not null |   | 完成時間 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `index_id` | PRIMARY |   |


## Table: `currency`<span id="currency"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

貨幣

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `currency_id` | INT | PRIMARY, Not null |   | 貨幣ID |
| `currency_name` | VARCHAR(45) | Not null |   | 貨幣名稱 |
| `denom` | INT | Not null |   | 匯率<br />錢轉分數的匯率 (單位 1/100): 分數=錢/(Denom/100)=錢x(100/Denom) |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `currency_id` | PRIMARY |   |


## Table: `game`<span id="game"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

遊戲

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `game_id` | INT | PRIMARY, Not null |   | 遊戲ID |
| `game_name` | VARCHAR(45) | Not null |   | 遊戲名稱 |
| `game_code` | VARCHAR(45) | Not null |   | 遊戲代碼<br />cq9使用 |
| `game_class_id` | INT | Not null |   | 遊戲類別ID<br />主類別 |
| `game_type_id` | INT | Not null |   | 遊戲類型ID<br />類別下的子類型 |
| `line` | INT | Not null |   | 線數<br />slot使用 |
| `bet_multiples` | VARCHAR(200) | Not null |   | 押注乘數<br />slot使用<br />逗點分隔的int字串 |
| `bet_unit` | BIGINT | Not null |   | 押注單位\<br />slot使用\<br />bet_unit x bet_multiple x line = total bet |
| `room_num` | INT | Not null |   | 預開的房間數 |
| `seat_num` | INT | Not null |   | 預開的座位數 |
| `flag` | BIGINT | Not null |   | 旗標<br />每一個bit表示一個開關<br />0: 遊戲是否開放 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `game_id` | PRIMARY |   |


## Table: `game_class`<span id="game_class"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

遊戲類別

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `game_class_id` | INT | PRIMARY, Not null |   | 遊戲類別ID |
| `game_class_name` | VARCHAR(45) | Not null |   | 遊戲類別名稱 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `game_class_id` | PRIMARY |   |


## Table: `game_type`<span id="game_type"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

遊戲類型<br />類別下的子類型

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `game_class_id` | INT | PRIMARY, Not null |   | 遊戲類別ID |
| `game_type_id` | INT | PRIMARY, Not null |   | 遊戲類型ID |
| `game_type_name` | VARCHAR(45) | Not null |   | 遊戲類型名稱 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `game_class_id`, `game_type_id` | PRIMARY |   |


## Table: `log_api`<span id="log_api"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

api request/response紀錄

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | BIGINT | PRIMARY, Auto increments, Not null |   | 流水號 |
| `operator_id` | INT | Not null |   | 營運商ID |
| `user_name` | VARCHAR(255) | Not null |   | 使用者名稱 |
| `account_id` | INT | Not null |   | 帳號ID |
| `api_name` | VARCHAR(255) | Not null |   | api名稱 |
| `response` | TEXT | Not null |   | response內容 |
| `timestamp` | BIGINT | Not null |   | 建立時間 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |


## Table: `log_error`<span id="log_error"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

錯誤紀錄

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | BIGINT | PRIMARY, Auto increments, Not null |   | 流水號 |
| `operator_id` | INT | Not null |   | 營運商ID |
| `user_name` | VARCHAR(45) | Not null |   | 使用者名稱 |
| `api_name` | VARCHAR(45) | Not null |   | api名稱 |
| `response` | TEXT | Not null |   | response內容 |
| `timestamp` | BIGINT | Not null |   | 建立時間 |
| `error_code` | INT | Not null |   | 錯誤碼 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |


## Table: `log_login`<span id="log_login"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 



### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | BIGINT | PRIMARY, Auto increments, Not null |   |   |
| `account_id` | INT | Not null |   |   |
| `account` | VARCHAR(255) | Not null |   |   |
| `balance` | BIGINT | Not null |   |   |
| `currency` | VARCHAR(10) | Not null |   |   |
| `game_code` | VARCHAR(45) | Not null |   |   |
| `operator_id` | INT | Not null |   |   |
| `game_type` | VARCHAR(45) | Not null |   |   |
| `timestamp` | BIGINT | Not null |   |   |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |


## Table: `log_logout`<span id="log_logout"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 



### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | BIGINT | PRIMARY, Auto increments, Not null |   |   |
| `account_id` | INT | Not null |   |   |
| `account` | VARCHAR(255) | Not null |   |   |
| `balance` | BIGINT | Not null |   |   |
| `currency` | VARCHAR(45) | Not null |   |   |
| `timestatmp` | BIGINT | Not null |   |   |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |


## Table: `log_order`<span id="log_order"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

轉入轉出紀錄

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | BIGINT | PRIMARY, Auto increments, Not null |   | 單號 |
| `account_id` | INT | Not null |   | 帳號ID |
| `operator_id` | INT | Not null |   | 營運商ID |
| `amount` | BIGINT | Not null |   | 金額<br />正數: 轉入錢包<br />負數: 轉出錢包 |
| `balance` | BIGINT | Not null |   | 操作完後的餘額 |
| `order_status` | TINYINT | Not null |   | 交易狀態<br />0: 成功<br />1: 餘額不足 |
| `create_time` | BIGINT | Not null |   | 建立時間 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |


## Table: `log_slot_bet`<span id="log_slot_bet"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

slot的注單<br />一局會有一個注單

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | BIGINT | PRIMARY, Auto increments, Not null |   | 流水號 |
| `account_id` | INT | Not null |   | 帳號ID |
| `player_code` | VARCHAR(255) | Not null |   | 玩家代碼<br />cq9用 |
| `game_id` | INT | Not null |   | 遊戲ID |
| `round_id` | BIGINT | Not null, Unique |   | 局ID |
| `bet` | BIGINT | Not null |   | 押注 |
| `win` | BIGINT | Not null |   | 贏的金額 |
| `balance` | BIGINT | Not null |   | 計算完bet、win後的餘額 |
| `fg_times` | INT | Not null |   | free game次數 |
| `ld_times` | INT | Not null |   | lucky draw次數 |
| `bg_times` | INT | Not null |   | bonus game次數 |
| `bet_time` | BIGINT | Not null |   | 押注時間 |
| `end_time` | BIGINT | Not null |   | 結算時間 |
| `status` | INT | Not null |   | 注單狀態<br />cq9用<br />0: 押注成功<br />1: win api失敗<br />2: win api成功<br />3: end api 成功<br />4: 已補帳 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |
| round_id_UNIQUE | `round_id` | UNIQUE |   |


## Table: `log_slot_bet_detail`<span id="log_slot_bet_detail"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

slot的細單<br />每個spin對應一個細單

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `id` | BIGINT | PRIMARY, Auto increments, Not null |   | 流水號 |
| `player_code` | VARCHAR(255) | Not null |   | 玩家代碼\<br />cq9用 |
| `game_id` | INT | Not null |   | 遊戲ID |
| `round_id` | BIGINT | Not null, Unique |   | 局ID |
| `game_mode` | INT | Not null |   | 遊戲模式<br />0: base game<br />1: bonus game<br />2: lucky draw<br />3: free game |
| `spin_serial` | INT | Not null |   | 此局free game spin的流水號 |
| `win` | BIGINT | Not null |   | 贏的金額 |
| `spin_time` | BIGINT | Not null |   | spin的時間 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `id` | PRIMARY |   |
| round_id_UNIQUE | `round_id` | UNIQUE |   |


## Table: `operator`<span id="operator"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

營運商

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `operator_id` | INT | PRIMARY, Not null |   | 營運商ID |
| `operator_code` | VARCHAR(45) | Not null |   | 營運商代碼 |
| `team_code` | VARCHAR(45) | Not null |   | 團隊代碼<br />cq9用 |
| `encrypt_key` | VARCHAR(255) | Not null |   | 加密金鑰<br />錢包API用 |
| `note` | VARCHAR(100) | Not null |   | 說明 |
| `is_deleted` | SMALLINT | Not null |   | 邏輯刪除 |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `operator_id` | PRIMARY |   |


## Table: `system_value`<span id="system_value"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#標題">(回到標題)</a>

### Description: 

系統用的key-value

### Columns: 

| Column | Data type | Attributes | Default | Description |
| --- | --- | --- | --- | ---  |
| `skey` | VARCHAR(45) | PRIMARY, Not null |   | key<br />last_bet_sync_time: 上次注單與cq9同步的時間<br />slot_round_id: slot的round id, 當作除注單round id外的另一個備援資料 |
| `svalue` | VARCHAR(255) | Not null |   | value |


### Indices: 

| Name | Columns | Type | Description |
| --- | --- | --- | --- |
| PRIMARY | `skey` | PRIMARY |   |


