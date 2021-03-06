require 'rails_helper'
RSpec.describe 'registration' do  
  it 'prompts for valid fields' do
  	visit '/'
  	expect(page).to have_field('First Name')
  	expect(page).to have_field('Last Name')
  	expect(page).to have_field('Email')
  	expect(page).to have_field('City')
  	expect(page).to have_field('State')
  	expect(page).to have_field('Password')
  	expect(page).to have_field('Password Confirmation')
  end

  it 'permits regitration with valid information' do
  	flan = create_user
  	expect(flan.first_name).to eq("Flannery")
  end
end