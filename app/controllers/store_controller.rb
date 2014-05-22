class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    # 自由課題D カウントは別メソッドにした方が良い
    @counter = increment_counter;
  end
end
