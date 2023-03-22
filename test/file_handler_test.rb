require 'test/unit'
require 'file_handler'

class TestFileHandler < Test::Unit::TestCase
  def setup
    @data = {"2023-02-16"=>{"USD"=>1.0, "GBP"=>0.84}}, {"2023-02-19"=>{"USD"=>1.0, "GBP"=>0.83}}
    @json_file = "test_file.json"
    File.write(@json_file, JSON.generate(@data))
  end

  def teardown
    File.delete(@json_file)
  end

  def test_read_json_file_returns_data_in_hash
    data = FileHandler.read_json_file(@json_file)
    assert_equal @data, data
  end
end