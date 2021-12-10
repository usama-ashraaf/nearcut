require 'rails_helper'
RSpec.describe "Home", type: :request do
  describe "GET /index" do
    let(:file) { fixture_file_upload('users.csv') }
    it "uploads the csv and show error validation" do
      get "/"
      expect(response.status).to eq(200)
    end
    it 'should read a csv' do
      post home_create_path, params: {file: file}
      @errors = ImportUsers.new(file.tempfile).import
      expect(@errors).to eq ["Muhammad was successfully saved", "Change 1 character of Maria Turing's password", "Change 4 character of Isabella's password", "Change 5 character of Axel's password"]
      expect(response.status).to eq(302)

    end
  end
end