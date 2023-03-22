require 'test/unit'
require 'repository/currency_repository'

class CurrencyRepositoryTest < Test::Unit::TestCase
  def test_data_is_returned_from_concrete_impl_json_repository
    currency_repository = CurrencyRepository.new('json')
    data = currency_repository.get_currency_data
    assert_not_nil(data)
  end

  def test_error_is_raised_from_concrete_impl_rdbms_repository
    assert_raise "Not implemented" do CurrencyRepository.new('rdbms').get_currency_data end
  end

  def test_error_is_raised_when_no_concrete_impl_exists
    assert_raise "Unknown currency repository" do CurrencyRepository.new("foo") end
  end
end