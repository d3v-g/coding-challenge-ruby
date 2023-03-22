require_relative './json_repository'
require_relative './rdbms_repository'

class CurrencyRepository
  def initialize(repo)
    case repo
    when 'json'
      @repo = JsonCurrencyRepository.new
    when 'rdbms'
      @repo = RdbmsCurrencyRepository.new
    else
      raise 'Unknown currency repository'
    end
  end
    
  def get_currency_data
    @repo.get_currency_data
  end
end
