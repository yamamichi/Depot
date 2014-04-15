require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products # ここで指定したfixtureを読み込む。ただし、デフォルトでは全てのfixtureを読み込む設定になっているので必要ないらしい
  # 全項目必須テスト
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  # priceテスト priceは0.01以上の数値を受け付ける
  test "product price must be positive" do
    product = Product.new(title:             "My Book Title",
                                         description:  "yyy",
                                         image_url:    "zzz.jpg");
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    
    product.price = 1
    assert product.valid?
  end

  # image_urlテスト 拡張子チェック
  def new_Product(image_url)
    Product.new(title:             "My Book Title",
                        description:  "yyy",
                        price:            1,
                        image_url:    image_url)
  end

  # 拡張子はjpg, gif, pngのみ受け付ける
  test "image_url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    ng = %w{ fred.doc fred.gif/more ferd.gif.more }

    ok.each do |name|
      assert new_Product(name).valid?, "#{name} should'n't be invalid"
    end

    ng.each do |name|
      assert new_Product(name).invalid?, "#{name} should'n't be valid"
    end
  end

  # titleテスト 重複チェック
  test "title is not valid without unique title" do
    product = Product.new(title:             products(:ruby).title,
                                         description:  "yyy",
                                         price: 1,
                                         image_url:    "zzz.jpg");
    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
    assert_equal I18n.translate("activerecord.errors.messages.taken"), product.errors[:title].join('; ') # 文字列をハードコードしない場合は、このようにして組み込みエラーメッセージを読み込める
  end
end
