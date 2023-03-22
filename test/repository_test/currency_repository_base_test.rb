require 'test/unit'
require 'repository/currency_repository_base'

class CurrencyRepositoryBaseTest < Test::Unit::TestCase
  def test_error_is_raised_when_base_class_calls_get_currency_data
    assert_raise "Base class method get_currency_data, not implemented" do CurrencyRepositoryBase.get_currency_data end
  end
end