require 'rails_helper'

RSpec.describe User, type: :model do
  it 'requires a first name, last name, city and state of at least length 2' do 
    user = User.new(first_name: '', last_name: "B", city: '', state: 'CA')
    user.valid?
    expect(user.errors[:first_name][0]).to eq("can't be blank")
    expect(user.errors[:last_name][0]).to eq("is too short (minimum is 2 characters)")
    expect(user.errors[:city][0]).to eq("can't be blank")
  end
  it 'requires a valid email' do
  	user = User.new(email: "grgrgrgjri")
  	user.valid?
  	expect(user.errors[:email][0]).to eq("is invalid")
  end
  it 'requires a password of at least length 8' do
    user = User.new(password: "hrhr")
    user.valid?
    expect(user.errors[:password][0]).to eq("is too short (minimum is 8 characters)")
  end
  it 'requires that password and password_confirmation match' do
  	user = User.new(password: "pacman91", password_confirmation: "nogoodie")
  	user.valid?
  	expect(user.errors[:password_confirmation][0]).to eq("doesn't match Password")
  end
  it 'automatically encrypts the password into the password_digest attribute' do
  	user = User.new(password: "hahahaie", password_confirmation: "hahahaie")
  	user.valid?
  	expect(user.password_digest.present?).to eq(true)
  end
end
