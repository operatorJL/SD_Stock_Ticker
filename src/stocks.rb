require 'open-uri'
module Stocks
  def calculate_net_asset(price: 0, shares: 0)
    price * shares
  end

  def calculate_total_worth(net_assets: 0)  
    net_assets.reduce(:+)  
  end

  def get_price_from_symbol(stock_symbol)
    call_web_service(stock_symbol)
    rescue Exception => ex
      0
  end
  
  def sort_assets_descending(stocks)
    stocks.sort_by! { |symbol, worth| -symbol[:worth] }
  end

  def call_web_service(stock_symbol)
    open("http://ichart.finance.yahoo.com/table.csv?s=#{stock_symbol}").to_a[1].split(",").last.to_f
  end
end