class GroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to action: :index
  end

  def edit
    @group = Group.find(params[:id])

  end

  def index
    @groups = Group.where(user: current_user).all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @cards = @group.cards
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to @group
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

end
