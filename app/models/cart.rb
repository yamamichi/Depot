class Cart < ActiveRecord::Base
  # has_many:line_itemsで、1つのカートに多数の品目(line_items)が関連付けされていることを宣言
  # devendent: :destoryでカートを破棄してDBから削除した時には、カートに関連付けされている品目も削除する事を宣言
  has_many :line_items , dependent: :destory
end
