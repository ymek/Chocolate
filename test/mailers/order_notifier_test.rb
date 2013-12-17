require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Awesome Chocolates Order Confirmation", mail.subject
    assert_equal ["jane@example.com"], mail.to
    assert_equal ["amirtcheva@gmail.com"], mail.from
    assert_match /jane doe/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Awesome Chocolates Order Shipped", mail.subject
    assert_equal ["jane@example.com"], mail.to
    assert_equal ["amirtcheva@gmail.com"], mail.from
    #assert_match /<td>&times;<\/td.\s*<td>Chocolate Bar<\/td>/, mail.body.encoded
  end

end
