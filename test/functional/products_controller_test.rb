require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @update = {
      title: 'Lorem Ipsom',
      description: 'Wibbles are fun!',
      image_url: 'lorem.jpg',
      price: 19.95
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
    assert_select ".list_description", minimum: 3
    assert_select "dt", 'Programming Ruby 1.9'
    assert_select ".list_line_odd", minimum: 2
    assert_select ".list_line_even", minimum: 1
    # 各レコードに、aタグが3つある（詳細、編集、削除）ことを確認
    assert_select '.list_actions' do |elements|
      elements.each do |element|
        assert_select element, "a", 3
      end
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: @update 
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product.to_param
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product.to_param, product:@update 
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product.to_param
    end

    assert_redirected_to products_path
  end
end
