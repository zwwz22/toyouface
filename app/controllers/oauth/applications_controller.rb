class Oauth::ApplicationsController < Doorkeeper::ApplicationsController
  before_filter :authenticate_user!
  def index
    super
  end

  def create
    super
  end
end
