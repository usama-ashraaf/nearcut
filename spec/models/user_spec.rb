require 'rails_helper'
RSpec.describe User, :type => :model do
  context "with 2 or more comments" do
    it "orders them in reverse chronologically" do
      expect { User.create!(name: 'test1', password:'1234').to raise_error('Password is too short (minimum is 10 characters), Password is invalid') }
    end
  end
end