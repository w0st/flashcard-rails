require 'rails_helper'

describe 'Quiz', type: :feature do

  def sign_in user
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def submit_form
    within 'body > .container' do
      find("input[type='submit']").click
    end
  end

  let!(:user) { create :user }
  before { sign_in user }

  context 'any card not exists' do
    it 'start' do
      visit 'quiz'
      expect(page).to have_content "You don't have any cards to launch a quiz"
    end
  end

  context 'cards exist' do
    let!(:group) { create :group, user: user }
    let!(:card1) { create :card, group: group }
    let!(:card2) { create :card, group: group }

    it 'start' do
      visit 'quiz'
      all("input[type='checkbox']").each do |cb|
        cb.set 'true'
      end
      submit_form
      expect(page).to have_content "Question"
    end

    it 'skip answer' do
      visit 'quiz'
      all("input[type='checkbox']").each do |cb|
        cb.set 'true'
      end
      submit_form
      2.times do
        expect(page).to have_content "Question"
        submit_form
      end
      expect(page).to have_content "Summary"
    end

=begin
    it 'answer correctly' do
      visit 'quiz'
      all("input[type='checkbox']").each do |cb|
        cb.set 'true'
      end
      submit_form
      fill_in '#answer', with: card1.back
      submit_form
      expect(page).to have_content "Summary"
    end
=end
  end
end