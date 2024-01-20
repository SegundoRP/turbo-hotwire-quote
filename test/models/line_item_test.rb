require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "#total_price returns the total price of the line item" do
    assert_equal 250, line_items(:catering_today).total_price
  end

  test "Creating a new line item" do
    assert_text number_to_currency(@quote.total_price)
  end

  test "Updating a line item" do
    assert_text number_to_currency(@quote.total_price)
  end

  test "Destroying a line item" do
    assert_text number_to_currency(@quote.total_price)
  end
end
