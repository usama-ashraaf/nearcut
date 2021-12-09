class HomeController < ApplicationController
  require 'csv'
  before_action :validate_params, only: [:create]

  def index
    @errors =  params[:errors]
  end

  def create
    begin
      @errors = ImportUsers.new(params[:file].tempfile).import
      redirect_to root_path(errors: @errors)
    rescue Exception => e
      return "Error: #{e}"
    end
  end

  private

  def validate_params
    unless params[:file].present?
      redirect_to root_path, alert: "Add csv file to upload users!"
    end
  end
end
