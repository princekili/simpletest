# simpletest



> 透過商品分類，呈現對應的商品清單列表
>
> 商品清單需顯示：1. 商品名稱 2. 售價 3. 建議售價 4. 可售數量



### 功能

- 使用原生 URLSession
- 排序
  - 價格由低到高
  - 價格由高到低
  - 銷售時間舊到新
  - 銷售時間新到舊
- 篩選
  - 尚有庫存的商品，`isSoldOut` = false
  - 尚未開賣的商品，`isComingSoon` = true
- 使用 GCD 佳



### API

- 取得***分類序號***
  - https://blooming-oasis-01056.herokuapp.com/category
  - `id`: 分類序號
  - `name`: 分類名稱
- 取得***商品資訊 (1)***
  - https://blooming-oasis-01056.herokuapp.com/product?id={id}，id: 分類序號
  - `salePageId`: 商品序號
  - `title`: 商品名稱
  - `price`: 售價
  - `suggestPrice`: 建議售價
- 取得***商品資訊 (2)***
  - https://blooming-oasis-01056.herokuapp.com/sale?id={id}，id: 分類序號
  - `salePageId`: 商品序號
  - `sellingQty`: 可售數量
  - `isSoldOut`: 商品已售完
  - `isComingSoon`: 商品尚未開賣
  - `sellingStartDateTime`: 銷售時間



### UI



### 完成後請發 Merge request