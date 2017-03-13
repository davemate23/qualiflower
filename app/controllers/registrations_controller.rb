class RegistrationsController < Devise::RegistrationsController
  clear_respond_to
  respond_to :json

  # def create
  #
  #
  #
  #   super
  # end
end