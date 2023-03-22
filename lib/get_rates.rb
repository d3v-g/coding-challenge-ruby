require 'config/currency_config'

module GetRates
  def self.is_base?(currency)
    return currency == CurrencyConfig::BASE_CURRENCY
  end

  def self.has_rates_on_date?(data, date)
    return data[date.to_s] != nil
  end

  def self.has_rate?(data, date, currency)
    if is_base?(currency)
      return true
    else return data[date.to_s][currency] != nil
    end
  end

  def self.find_rate(data, date, currency)
    if is_base?(currency)
      return 1
    else return data[date.to_s][currency]
    end
  end
end