module Yodlee
  class Base

    include HTTParty

    cattr_accessor :current_session_token, :user_session,  :current_session_started

    def cobrand_token
      fresh_token? ? current_session_token : login_app 
    end

    def query opts
      if user_session.to_s.strip.length == 0
        sessionToken = "{cobSession=#{current_session_token}}";
      else
        sessionToken = "{cobSession=#{current_session_token}, userSession=#{user_session}}";
      end

      puts sessionToken
      method   = opts[:method].to_s.downcase
      response = self.class.send(method, opts[:endpoint], query: opts[:params], headers: {"Authorization"=>sessionToken})

      data = response.parsed_response

      if response.success?
        if [ TrueClass, FalseClass, Fixnum ].include?(data.class)
          data
        else
          convert_to_mash(data)
        end
      else
        nil
      end
    end


    private

    def convert_to_mash data
      if data.is_a? Hash
        Hashie::Mash.new(data)
      elsif data.is_a? Array
        data.map { |d| Hashie::Mash.new(d) }
      end
    end

    def login_app
      response = query({
        :endpoint => '/cobrand/login',
        :method => :POST,
        :params => {
          :cobrandLogin => Yodlee::Config.cob_username,
          :cobrandPassword => Yodlee::Config.cob_password
        }
      })
      self.current_session_started = Time.zone.now
      self.current_session_token = response.session.cobSession

      response = query({
        :endpoint => '/user/login',
        :method => :POST,
        :params => {
          :loginName => Yodlee::Config.user_name,
          :password => Yodlee::Config.user_password
        }
      })
      self.user_session = response.user.session.userSession

    end
     
    def fresh_token?
      current_session_token && current_session_started && current_session_started >= 90.minutes.ago
    end

  end
end

#    # First Test
#    def login_app
#      credentials = {
#        :cobrandLogin => Yodlee::Config.username,
#        :cobrandPassword => Yodlee::Config.password
#      }
#      response = self.class.post('/authenticate/coblogin', query: credentials)
#   end
