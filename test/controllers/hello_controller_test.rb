require 'test_helper'

class HelloControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # test 'list action' do
  #     get '/hello/list'
  #     assert_equal 10, assigns(:books).length, 'found rows is wrong.'
  #     assert_response :success, 'list action failed.'
  #     assert_template 'hello/list'
  # end

  test "routing check" do
      assert_generates('hello/list', { controller: 'hello', action: 'list' })
  end

  test "routing check" do
      
  end
end
