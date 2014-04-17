class LineItem < ActiveRecord::Base
  # テーブルに外部キーが有る場合、そのテーブルに対応sるうモデルにはキー毎にbelongs_toを記述する
  # このように宣言することで、例えば以下のようなコードを書くことができるようになる
  # li = LineItem.find(....)  # li.product.titleでタイトルを取得できる
  # cart = Cart.find(....)  # cart.line_items.countでカートに含まれている商品の個数を取得できる
  belongs_to :product
  belongs_to :cart
end
