require_relative './currency_repository_base'
require_relative '../file_handler'
require_relative '../config/currency_config'

class JsonCurrencyRepository < CurrencyRepositoryBase
	def get_currency_data
    file_dir = File.join(File.dirname(__FILE__), CurrencyConfig::JSON_REPO_CONFIG[:json_file_path])
    FileHandler.read_json_file(file_dir)
	end
end