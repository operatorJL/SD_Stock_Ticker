$:.unshift(File.join(File.dirname(__FILE__), 'src')) 
require './src/run_stocks'


task :run_stock_tests do
  ruby "test/stocks_test.rb"
end

task :run_stocks do
  run
end

task :default => :run_stock_tests