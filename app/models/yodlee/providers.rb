module Yodlee
  class Providers < Base
    def all_providers
      response = query({
        :endpoint => '/providers',
        :method => :GET,
      })
      puts response.inspect
    end

  end
end
