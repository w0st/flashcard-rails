require 'rails_helper'

RSpec.describe Group, type: :model do
  user = User.create(email: 'user@domain.com', password: 'password', password_confirmation: 'password')

  it 'must have name' do
    expect { Group.create!(user: user) }.to raise_error

    expect { Group.create!(name: 'English words', user: user) }.to_not raise_error
  end

  it 'must have unique name' do
    expect do
      Group.create!(name: 'English words', user: user)
      Group.create!(name: 'English words', user: user)
    end.to raise_error
  end

  it 'can have name, description, icon' do
    expect do
      Group.create!(user: user, name: 'Fruits', description: 'Many fruits...', icon: 'fruits.png')
    end.to_not raise_error
  end

  it 'can have only valid icon' do
    expect do
      Group.create!(user: user, name: 'Fruits', description: 'Many fruits...', icon: 'strange_path/fruits.png')
    end.to raise_error

    expect do
      Group.create!(user: user, name: 'Fruits', description: 'Many fruits...', icon: 'fruits.mp3')
    end.to raise_error

    expect do
      Group.create!(user: user, name: 'Fruits', description: 'Many fruits...', icon: 'fruits.png')
    end.to_not raise_error
  end

end
