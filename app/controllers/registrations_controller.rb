class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    puts params['users']['type']
  end

  def update
    super
  end
end 
