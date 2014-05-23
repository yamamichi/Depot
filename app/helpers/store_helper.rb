# encoding: utf-8

module StoreHelper
  def report_count
    if @counter == 0
      response = 'Welcome!'
    elsif @counter < 5 # elseifではなくelsifなので注意
      response = "";
    else
      # 数字を文字列連結する場合、to_sメソッドで文字列にしておかないとエラーになってしまうので注意
      response = "このページにくるのは" + @counter.to_s + "回目です"
    end
    return response
  end
end
