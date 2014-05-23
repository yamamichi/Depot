require 'active_record/errors'

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
    def current_cart 
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

  # 自由課題D ページに来た回数をカウントする
  private 
    def increment_counter
      if session[:counter].nil?
        session[:counter] = 0
      else
        session[:counter] += 1
      end
    end
  # 自由課題D ページに来た回数をリセットする
  private 
    def reset_counter
      session[:counter] = 0
    end  
end
