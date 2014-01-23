$:.unshift(File.join(File.dirname(__FILE__), '..','src')) 
require 'simplecov'
SimpleCov.start
require 'stocks'
require 'json'
require 'test/unit'
require 'mocha/setup'
include Stocks


class StocksTest < Test::Unit::TestCase
  
  def test_canary_test_for_stock_test 
    assert true
  end
  
  def test_calculates_net_assets_with_positive_price
    assert_equal 7.50, calculate_net_asset(price: 2.50, shares: 3)
  end
  
  def test_calculates_net_assets_with_negative_price
    assert_equal -7.50, calculate_net_asset(price: -2.50, shares: 3)
  end
  
  def test_calculates_net_assets_with_zero_price
    assert_equal 0, calculate_net_asset(price: 0, shares: 3)
  end
  
  def test_calculates_total_net_worth_for_zero_assets
    assert_nil calculate_total_worth(net_assets: [])
  end
  
  def test_calculates_total_net_worth_for_one_asset
    assert_equal 5.50, calculate_total_worth(net_assets: [5.50])
  end
  
  def test_calculates_total_net_worth_for_two_positive_assets
    assert_equal  8.00, calculate_total_worth(net_assets: [5.50, 2.50])
  end
  
  def test_calculates_total_net_worth_for_one_negative_asset
    assert_equal -50.25, calculate_total_worth(net_assets: [-50.25])
  end
  
  def test_calculates_total_net_worth_for_two_negative_assets
    assert_equal -75.00, calculate_total_worth(net_assets: [-50.00, -25.00])
  end
  
  def test_return_zero_for_no_stock_symbols
    stock_symbol = ''
    expects(:call_web_service).with(stock_symbol).returns(0)
    assert_equal 0, get_price_from_symbol(stock_symbol)
  end
  
  def test_get_price_given_one_stock_symbol
    stock_symbol = 'AAPL'
    expects(:call_web_service).with(stock_symbol).returns(200.00)
    assert_equal 200.00, get_price_from_symbol(stock_symbol)
  end
  
  def test_call_web_service_with_no_internet
    stock_symbol = 'AAPL'
    expects(:call_web_service).with(stock_symbol).raises(Exception)
    assert_equal 0, get_price_from_symbol(stock_symbol)
  end
  
  def test_call_web_service_with_invalid_symbol
    stock_symbol = 'BAD_SYMBOL'
    expects(:call_web_service).with(stock_symbol).raises(Exception)
    assert_equal 0, get_price_from_symbol(stock_symbol)
  end
  
  def test_sort_assets_with_no_values
    stocks = []
    assert_equal [], sort_assets_descending(stocks)
  end
  
  def test_sort_assets_descending_with_two_values
    stocks = [{symbol: 'goog', price: 140.00, shares: 200, worth: 28000.00},
            {symbol: 'aapl', price: 144.00, shares: 232, worth: 33408.00}]
    sorted_stocks = sort_assets_descending(stocks)
    assert_equal 33408.00, sorted_stocks[0][:worth]
  end
  
  def test_real_web_service_with_valid_symbol_returns_greater_than_zero
    stock_symbol = "AAPL"
    assert call_web_service(stock_symbol) > 0
  end
  
  def test_real_web_service_with_invalid_symbol_raises_httperror
    stock_symbol = "invalid"
    assert_raise(OpenURI::HTTPError) { call_web_service(stock_symbol) }
  end 
end













