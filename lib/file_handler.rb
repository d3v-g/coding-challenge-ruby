require 'json'

module FileHandler
  def self.read_json_file(path)
    file_extension = File.extname(path)
    file = File.open(path, 'r')
    data = JSON.load file
    file.close()
    return data
  end
end