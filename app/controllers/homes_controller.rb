class HomesController < ApplicationController
  #doorkeeper_for :all

  def index

  end

  def show
    redirect_to :action => 'index'
  end
end
