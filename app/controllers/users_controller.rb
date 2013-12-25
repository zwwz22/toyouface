class UsersController < ApplicationController

  def index
    @users = User.order_desc.all
    respond_to do |format|
      format.html
      format.xls {
        send_data @users.to_xls(:columns => [:name],:headers => ['姓名']), :filename => 'users22.xls'
      }
    end
    a = YAML.load(File.read("#{Rails.root}/config/test.yml"))

    p a['test']['test1']
  end

  def new
    @user = User.new
    #authorize! :update, @user
    redirect_to :back,:notice => '1111'

  end

  def create

  end

  def edit
    @user = User.find params[:id]
  end

end
