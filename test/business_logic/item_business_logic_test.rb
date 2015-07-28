require "./test/test_helper"
class ItemApiBusinessLogicTest < ApiTest
  def test_loads_the_best_day_associated_with_one_item
    item_id_one  = 1099
    item_id_two  = 2198
    best_day_one = load_data("/api/v1/items/#{item_id_one}/best_day")
    best_day_two = load_data("/api/v1/items/#{item_id_two}/best_day")

    assert_equal "Fri Mar 23 00:00:00 2012", best_day_one
    assert_equal "Sun Mar 18 00:00:00 2012", best_day_two
  end

  def test_loads_a_variable_number_of_top_items_ranked_by_total_number_sold
    group_size_one = 1
    group_size_two = 5

    total_revenue_one = load_data("/api/v1/items/most_items?quantity=#{group_size_one}")
    total_revenue_two = load_data("/api/v1/items/most_items?quantity=#{group_size_two}")

    assert_equal group_size_one, total_revenue_one.size
    assert_equal group_size_two, total_revenue_two.size

    [total_revenue_one, total_revenue_two].each do |total|
      assert_equal 227,                total.first['id']
      assert_equal "Item Dicta Autem", total.first['name']
    end

    assert_equal 104,             total_revenue_one[3]['id']
    assert_equal "Item Et Sequi", total_revenue_one[6]['name']
  end

  def test_loads_a_variable_number_of_top_merchants_ranked_by_total_revenue
    group_size_one = 1
    group_size_two = 3

    total_revenue_one = load_data("/api/v1/items/most_revenue?quantity=#{group_size_one}")
    total_revenue_two = load_data("/api/v1/items/most_revenue?quantity=#{group_size_two}")

    assert_equal group_size_one, total_revenue_one.size
    assert_equal group_size_two, total_revenue_two.size

    [total_revenue_one, total_revenue_two].each do |total|
      assert_equal 227,                total.first['id']
      assert_equal "Item Dicta Autem", total.first['name']
    end

    assert_equal 2174,              total_revenue_one[1]['id']
    assert_equal "Item Nam Magnam", total_revenue_one[6]['name']
  end
end