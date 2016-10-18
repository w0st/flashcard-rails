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
    @group = Group.where(user: current_user).find_by id: params[:id]
    if @group
      @group.destroy
      redirect_to action: :index
    else
      flash[:alert] = t('group_not_exists_or_not_have_priviliges')
      redirect_to :root
    end
  end

  def edit
    @group = Group.where(user: current_user).find_by id: params[:id]
    unless @group
      flash[:alert] = t('group_not_exists_or_not_have_priviliges')
      redirect_to :root
    end
  end

  def index
    @groups = Group.where(user: current_user).all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.where(user: current_user).find_by id: params[:id]
    if @group
      @cards = @group.cards
    else
      flash[:alert] = t('group_not_exists_or_not_have_priviliges')
      redirect_to :root
    end
  end

  def update
    @group = Group.where(user: current_user).find_by id: params[:id]
    if @group && @group.update(group_params)
      redirect_to @group
    elsif @group
      render :edit
    else
      flash[:alert] = t('group_not_exists_or_not_have_priviliges')
      redirect_to :root
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

end
