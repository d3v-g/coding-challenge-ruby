require_relative './currency_repository_base'

class RdbmsCurrencyRepository < CurrencyRepositoryBase
  def get_currency_data
    raise 'Not implemented'
  end
end