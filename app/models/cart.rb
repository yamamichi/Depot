# encoding: utf-8

class Cart < ActiveRecord::Base
  # has_many:line_itemsで、1つのカートに多数の品目(line_items)が関連付けされていることを宣言
  # devendent: :destoryでカートを破棄してDBから削除した時には、カートに関連付けされている品目も削除する事を宣言
  has_many :line_items , dependent: :destroy

  # カートに商品を足す
  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item # 最後に書いた変数がreturnされる。return current_itemと同じ意味だと思ってよさそう
  end
end
