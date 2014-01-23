require 'stocks'
include Stocks

def run
  print_report(get_price_and_total_worth(read_symbol_and_shares_from_file))
end

def read_symbol_and_shares_from_file
  file = File.open("stocks.txt")
  stock_data = {}
  File.open('stocks.txt', 'r') do |file|
    file.each_line do |line|
      data = line.split(',')
      stock_data[data[0]] = data[1]
    end
  end
  stock_data
end

def get_price_and_total_worth(stock_data)
  stocks = []
  total = []
  stock_data.each do |symbol, shares|
    price = get_price_from_symbol(symbol)
    worth = calculate_net_asset(price: price, shares: shares.to_i)
    total << worth
    stocks << {symbol: symbol, price: price, shares: shares.to_i, 
              worth: worth}
  end
  return stocks, calculate_total_worth(net_assets: total)
end

def print_report(stock_data)
  printf("%10s %10s %20s %10s\n", "SYMBOL", "PRICE", "NUMBER OF SHARES", "WORTH")
  sorted_data = sort_assets_descending(stock_data[0])
  sorted_data.each do |symbol, price, shares, worth|
    printf("%10s %10s %15d %15s\n",symbol[:symbol], "$#{symbol[:price]}", symbol[:shares], "$#{symbol[:worth]}")
  end
  puts "total: $ #{stock_data[1]}"
end