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
    Cart.all.each do |cart|
      sums = cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, quantity|
        if quantity > 1
          cart.line_items.where(product_id: product_id).delete_all
          quantity.times do 
            cart.line_items.create(product_id: product_id, quantity: 1)
          end # quantity
        end # if
      end # sums
    end # cart.all
  end # def

end
