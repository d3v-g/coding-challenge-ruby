require 'test/unit'
require 'currency_exchange'
require 'date'

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
    @data = {
      "2018-11-22"=>{
        "USD"=>1.1403,
        "JPY"=>128.8,
        "GBP"=>0.88598
      }
    }
  end
  
  def test_rate_method_returns_correct_rate_for_non_base_currency
    correct_rate = 1.2870493690602498
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "GBP", "USD")
  end

  def test_rate_method_returns_correct_rate_for_base_currency
    correct_rate = 0.007763975155279502
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "JPY", 'EUR')
  end

  def test_rate_method_returns_correct_rate_for_lowercase_arg
    correct_rate = 1.2870493690602498
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "gbp", "usd")
  end

  def test_rate_method_returns_correct_rate_for_whitespace_arg
    correct_rate = 1.2870493690602498
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), " GBP", " USD")
  end

  def test_arg_error_is_raised_when_rate_does_not_exist_for_date
    assert_raise(ArgumentError.new("No rate for 2023-02-11, please try again")) do 
      CurrencyExchange.validate_rates(@data, Date.new(2023,02,11), 'EUR', "JPY", "GBP")
    end
  end

  def test_arg_error_is_raised_when_rate_does_not_exist_for_from_currency
    assert_raise(ArgumentError.new("No rate for FOO on 2018-11-22, please try again")) do 
      CurrencyExchange.validate_rates(@data, Date.new(2018,11,22), 'EUR', "FOO", "GBP")
    end
  end

  def test_arg_error_is_raised_when_rate_does_not_exist_for_to_currency
    assert_raise(ArgumentError.new("No rate for BAR on 2018-11-22, please try again")) do 
      CurrencyExchange.validate_rates(@data, Date.new(2018,11,22), 'EUR', "GBP", "BAR")
    end
  end
end
