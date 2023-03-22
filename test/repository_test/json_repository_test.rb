require 'test/unit'
require 'repository/json_repository'

class JsonRepositoryTest < Test::Unit::TestCase
  def test_get_currency_data_returns_data
    assert_not_nil(JsonCurrencyRepository.new().get_currency_data)
  end
end