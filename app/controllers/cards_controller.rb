class CardsController < ApplicationController
  before_action :authenticate_user!

  def create
    @card = Card.new(card_params)
    @group = Group.find(params[:group_id])
    @card.group = @group
    if @card.save
      redirect_to @card.group
    else
      redirect_to action: :new
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to @card.group
  end

  def edit
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
    @group = Group.find(params[:group_id])
  end

  def show
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to @card.group
    else
      redirect_to action: :edit
    end
  end

  private

  def card_params
    params.require(:card).permit(:front, :back)
  end
end
