class ApplicationController < ActionController::Base
  include Pagy::Backend

  def hello
    p hello
  end
end
