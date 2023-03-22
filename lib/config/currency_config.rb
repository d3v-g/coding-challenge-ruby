module CurrencyConfig
    # ISO 4217 three-letter code, e.g. EUR, GBP, USD
    BASE_CURRENCY = ENV.has_key?('BASE_CURRENCY') ? ENV['BASE_CURRENCY'] : 'EUR'
    # data source type used, e.g. json, rdbms
    SOURCE_DATA_TYPE = ENV.has_key?('SOURCE_DATA_TYPE') ? ENV['SOURCE_DATA_TYPE'] : 'json'

    ##############################
    # Currency Repository Config #
    ##############################
    # Define JSON repo config
    # relative path from repository folder to the source data
    JSON_REPO_CONFIG = {
      json_file_path: ENV.has_key?('JSON_FILE_PATH') ? ENV['JSON_FILE_PATH'] : '../../data/eurofxref-hist-90d.json'
    }

    # Define RDBMS repo config
    RDBMS_REPO_CONFIG = { 
      username: ENV.has_key?('RDBMS_USERNAME') ? ENV['RDBMS_USERNAME'] : 'admin',
      password: ENV.has_key?('RDBMS_PASSWORD') ? ENV['RDBMS_PASSWORD'] : 'password',
      url: ENV.has_key?('RDBMS_URL') ? ENV['RDBMS_URL'] : 'jdbc:mysql://localhost:3306/currency_data'
    }
end
