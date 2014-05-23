# encoding: utf-8

# 上記は日本語を使うためのマジックメソッド。view以外で日本語を使う際には毎回記載する必要がある
class Product < ActiveRecord::Base
  # 将来的に、カートが複数になった場合、ひとつのproductが複数のline_itemを持つ可能性があるため
  has_many :line_items
  # dbのレコードを削除しようとした際に呼び出される
  before_destroy :ensure_not_referenced_by_any_iine_item

  validates :title, :description, :image_url, presence: true  # 必須チェック
  validates :price, numericality:  {greater_than_or_equal_to: 0.01}  # 数値チェック
  validates :title, uniqueness: true # 重複チェック
  validates :image_url, allow_blank: true, format:{ 
    with: %r{\.(gif|jpg|png)$}i, #正規表現を使った拡張子チェック
    message: 'はgif, jpg, png画像のURLでなければなりません'  #チェック失敗時のエラーメッセージ
  }
  validates :title, length:{minimum: 10} #文字数チェック
  validates_length_of :image_url, in: 6..50, too_short: "ファイル名が短すぎます", too_long: "ファイル名が長過ぎます"

  private
    # このproductを参照しているline_itemが存在しないことを確認する
    def ensure_not_referenced_by_any_iine_item
      if line_items.empty?
        return true
      else
        errors.add(:base, '品目が存在します')  # errorsはvalidates()でエラーメッセージが格納される場所
        return false
    end
  end
end
