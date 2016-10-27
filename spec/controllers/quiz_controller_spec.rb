require 'rails_helper'

RSpec.describe QuizController, type: :controller do

  let(:user) { create(:user) }
  let!(:group) { create :group, user: user }
  let!(:card1) { create :card, group: group }
  let!(:card2) { create :card, group: group }

  before { sign_in user }

  describe 'GET #index' do
    subject { get :index}

    it { is_expected.to render_template :index}
  end

  describe 'POST #init' do
    subject { post :init, params: { group: Hash[group.id, 1] } }

    it 'receive params' do
      subject
      expect(session[:q_all]).to eq(2)
      expect(session[:q_current]).to eq(0)
      expect(session[:q_correct]).to eq(0)
    end
  end

  describe 'GET #question' do
    before do
      session[:q_all] = 2
      session[:q_current] = 0
      session[:q_correct] = 0
      session[:q_cards] = group.cards.ids
    end

    it 'show question' do
      get :question
      expect(assigns[:card]).to be_a(Card)
      is_expected.to render_template :question
    end
  end

  describe 'POST #answer' do
    before do
      session[:q_all] = 2
      session[:q_current] = 0
      session[:q_correct] = 0
      session[:q_cards] = group.cards.ids
    end

    subject { post :answer, params: { answer: 'some bad answer' } }

    it { is_expected.to redirect_to :quiz_question }

    it 'count answer' do
      subject
      expect(session[:q_current]).to eq(1)
    end

    it 'count correct answer' do
      post :answer, params: { answer: (Card.find group.cards[0].id).back }
      expect(session[:q_correct]).to eq(1)
    end
  end

  describe 'GET #end' do
    before do
      session[:q_all] = 2
      session[:q_current] = 2
      session[:q_correct] = 1
      session[:q_cards] = group.cards.ids
    end

    subject {get :end}

    it { is_expected.to render_template :end }

    it 'destroy quiz in session' do
      subject
      expect(session[:q_all]).to be_nil
      expect(session[:q_correct]).to be_nil
      expect(session[:q_current]).to be_nil
      expect(session[:q_cards]).to be_nil
    end
  end

end
