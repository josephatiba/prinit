require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it "is invalid without a first_name" do
    user = FactoryGirl.build(:user, first_name: nil)
    expect(user).to be_invalid
  end

  it "is invalid without a last_name" do
    user = FactoryGirl.build(:user, last_name: nil)
    expect(user).to be_invalid
  end

  it "is invalid without an email address" do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).to be_invalid
  end

  it "is invalid is the user tries to sign up with an email address that already exists in the database, regardless of capitalization" do
    user = FactoryGirl.create(:user, email: "test@example.com")
    user1 = FactoryGirl.build(:user, email: "test@example.com")
    user2 = FactoryGirl.build(:user, email: "test@example.com")
    expect(user1).to be_invalid
    expect(user2).to be_invalid
  end

  it "requires a unique email address regardless of case sensitivity" do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).to be_invalid
  end

  it "is invalid without proper email format" do
    user = FactoryGirl.build(:user, email: "j.j.com")
    expect(user).to be_invalid
  end

  it "is invalid without a username" do
    user = FactoryGirl.build(:user, username: nil)
    expect(user).to be_invalid
  end


  it "is invalid if password length is less than 2 characters" do
    user = FactoryGirl.build(:user, password: "1")
    expect(user).to be_invalid
  end

  it "is invalid if password is empty" do
    user = FactoryGirl.build(:user, password: "")
    expect(user).to be_invalid
  end

  it "is invalid if password length is greater than 20 characters" do
    user = FactoryGirl.build(:user, email: "1"*21)
    expect(user).to be_invalid
  end



end