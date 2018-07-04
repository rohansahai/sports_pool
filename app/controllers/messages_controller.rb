class MessagesController < ApplicationController
  def create
    message = params["Body"]
    user_phone_number = params["From"]
  end
end
