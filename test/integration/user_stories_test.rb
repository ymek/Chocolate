require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  #User story: a user goes to the index page and selects a product to add 
  #to their cart, and then they check out. After they've filled out
  #their information on the checkout page, they hit submit and their
  #form is sent to the server and an order and line_item are added to the 
  #database

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    chocolate = products(:lindt)

    get "/"
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', product_id: chocolate.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal chocolate, cart.line_items[0].product

    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders", order: {name: "jane doe", address: "MyText", email: "jane@example.com", pay_type: "Check"}
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "jane doe", order.name
    assert_equal "MyText", order.address
    assert_equal "jane@example.com", order.email
    assert_equal "Check", order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal chocolate, line_item.product 

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["jane@example.com"], mail.to
    assert_equal 'Alex <amirtcheva@gmail.com>', mail[:from].value
    assert_equal 'Awesome Chocolates Order Confirmation' , mail.subject
  end
end
