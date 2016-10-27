class QuizController < ApplicationController
  before_action :authenticate_user!

  def question
    expose_status
    if session[:q_current] < session[:q_all]
      @card = Card.find session[:q_cards][session[:q_current]]
    else
      redirect_to :quiz_end
    end
  end

  def index
    @groups = current_user.groups.select {|g| g.cards.size > 0}
  end

  def end
    redirect_to :quiz unless session[:q_current]
    expose_status
    session[:q_current] = nil
    session[:q_correct] = nil
    session[:q_cards] = nil
    session[:q_all] = nil
  end

  def answer
    @card = Card.find session[:q_cards][session[:q_current]]
    if params[:answer] == @card.back
        session[:q_correct] = session[:q_correct].next
    end
    session[:q_current] = session[:q_current].next
    redirect_to :quiz_question
  end

  def init
    session[:q_current] = 0
    session[:q_correct] = 0
    session[:q_cards] = []
    Group.find(group_ids_param).each do |group|
      session[:q_cards].concat group.cards.ids if group.user == current_user
    end
    session[:q_all] = session[:q_cards].size
    redirect_to :quiz_question
  end

  private

  def group_ids_param
    params.require(:group).permit!.to_h.select {|k,v| v == '1'}.map {|k,v| k}
  end

  def expose_status
    @q_current = session[:q_current]
    @q_correct = session[:q_correct]
    @q_all = session[:q_all]
  end

end
