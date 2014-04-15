require 'test_helper'

class ProductTest < ActiveSupport::TestCase
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

  # 以下、image_urlのテスト
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
  
end
