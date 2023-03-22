require 'get_rates'
require 'date'
require 'config/currency_config'
require 'repository/currency_repository'

module CurrencyExchange
  def self.rate(date, from_currency, to_currency)
    from_currency = from_currency.strip.upcase
    to_currency = to_currency.strip.upcase

    currency_repository = CurrencyRepository.new(CurrencyConfig::SOURCE_DATA_TYPE)
    data = currency_repository.get_currency_data()

    validate_rates(data, date, CurrencyConfig::BASE_CURRENCY, from_currency, to_currency)

    from_rate = GetRates.find_rate(data, date, from_currency)
    to_rate = GetRates.find_rate(data, date, to_currency)

    to_rate.to_f / from_rate.to_f
  end

  def self.validate_rates(data, date, base, from_currency, to_currency)
    if !GetRates.has_rates_on_date?(data, date)
      raise ArgumentError, "No rate for #{date}, please try again"
    end

    [from_currency, to_currency].each do |currency|
      if !GetRates.has_rate?(data, date, currency)
        raise ArgumentError, "No rate for #{currency} on #{date}, please try again"
      end
    end
  end
end