require 'spec_helper'

cob_session = nil

describe Yodlee do
  describe "codebrand signin" do
    it "login successfull" do
      cob_session =  Yodlee::Base.new.cobrand_token
      #puts cob_session
      expect(cob_session).not_to be_empty
    end
  end

  describe "codebrand providers" do
    it "get providers successfull" do
      cob_session =  Yodlee::Base.new.cobrand_token
      providers =  Yodlee::Providers.new.all_providers 
      expect(cob_session).not_to be_empty
      #puts providers
    end
  end
end


