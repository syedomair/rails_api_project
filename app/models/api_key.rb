class ApiKey < ActiveRecord::Base

  def self.authenticateApiKey(apiKey="")
    apiKey = ApiKey.find_by api_key: apiKey, status: 1
    if apiKey
      return true
    else
      return false
    end
  end
end
