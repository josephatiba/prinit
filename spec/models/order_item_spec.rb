require 'rails_helper'

RSpec.describe OrderItem, type: :model do

 

  

  it "is invalid without a quantity greater than zero" do 
    order_item = FactoryGirl.build(:order_item, quantity: 0)
    expect(order_item).to be_invalid
  end

 


end