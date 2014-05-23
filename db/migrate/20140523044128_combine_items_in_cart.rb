class CombineItemsInCart < ActiveRecord::Migration
  def up
    # カート内に１つの商品に対して複数の品目があった場合は、１つの品目に置き換える
    Cart.all.each do |cart|
      # カート内の各商品の数をカウントする
      sums = cart.line_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # 個別の品目を削除する
          cart.line_items.where(product_id: product_id).delete_all
          # １つの品目に置き換える
          cart.line_items.create(product_id: product_id, quantity: quantity)
        end #if
      end # sums
    end # Cart.all
  end # def 

  def down
    # 数量>1の品目を複数の品目に分割する
    LineItem.where("quantity > 1").each do |line_item|
      line_item.quantity.times do
        # 個別の品目を追加する
        LineItem.create(cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1) 
      end
      # 元の品目を削除する
      line_item.destroy
    end # Line_items.all
  end # def

end
