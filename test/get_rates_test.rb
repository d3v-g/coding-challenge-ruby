require 'test/unit'
require 'get_rates'
require_relative '../lib/repository/currency_repository'
require 'date'

class GetRatesTest < Test::Unit::TestCase
  def setup
    @data = {
      '2018-12-11'=>{
        'USD'=>1.1379,
        'JPY'=>128.75,
        'GBP'=>0.90228
      },
      '2018-12-10'=>{
        'USD'=>1.1425,
        'JPY'=>128.79,
        'GBP'=>0.90245
      }
    }
  end

  def test_is_base_returns_true_for_base_currency
    assert(GetRates.is_base?('EUR'))
  end

  def test_is_base_returns_false_for_non_base_currency
    assert(!GetRates.is_base?('GBP'))
  end

  def test_has_rates_on_date_returns_true_when_data_exists_for_date
    assert GetRates.has_rates_on_date?(@data, Date.new(2018, 12, 11))
  end

  def test_has_rates_on_date_returns_false_when_data_does_not_exist_for_date
    assert !GetRates.has_rates_on_date?(@data, Date.new(2023, 02, 19))
  end

  def test_has_rate_returns_true_when_rate_exists_for_date_and_currency
    assert GetRates.has_rate?(@data, Date.new(2018, 12, 11), 'USD')
  end

  def test_has_rate_returns_true_when_currency_is_base_currency
    assert GetRates.has_rate?(@data, Date.new(2018, 12, 11), 'EUR')
  end

  def test_has_rate_returns_false_when_rate_does_not_exist_for_date_and_currency
    assert !GetRates.has_rate?(@data, Date.new(2018, 12, 11), 'CNY')
  end

  def test_find_rate_returns_1_for_base_currency
    correct_rate = 1
    assert_equal correct_rate, GetRates.find_rate(@data, Date.new(2018, 12, 11), 'EUR')
  end

  def test_find_rate_returns_currect_rate_for_non_base_currency
    correct_rate = 0.90228
    assert_equal correct_rate, GetRates.find_rate(@data, Date.new(2018, 12, 11), 'GBP')
  end
end