# -*- encoding: utf-8 -*-
# 上記は日本語を使うためのマジックメソッド。view以外で日本語を使う際には毎回記載する必要がある
class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true  # 必須チェック
  validates :price, numericality:  {greater_than_or_equal_to: 0.01}  # 数値チェック
  validates :title, uniqueness: true # 重複チェック
  validates :image_url, allow_blank: true, format:{ 
    with: %r{\.(gif|jpg|png)$}i, #正規表現を使った拡張子チェック
    message: 'はgif, jpg, png画像のURLでなければなりません'  #チェック失敗時のエラーメッセージ
  }
  validates :title, length:{minimum: 10} #文字数チェック
  validates_length_of :image_url, in: 6..50, too_short: "ファイル名が短すぎます", too_long: "ファイル名が長過ぎます"
end
