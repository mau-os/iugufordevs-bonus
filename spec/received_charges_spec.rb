require 'spec_helper'

RSpec.describe ReceivedCharge do
  it 'return all received charges' do
    ReceivedCharge.clear
    a = []
    a << ReceivedCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_date: 20210510, status: 05)
    a << ReceivedCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_date: 20210430, status: 05)
    a << ReceivedCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_date: 20210312, status: 05)

    expect(ReceivedCharge.all).to eq(a)
  end

  it 'return sum of received charges' do
    ReceivedCharge.clear

    ReceivedCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_date: 20210510, status: 05)
    ReceivedCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_date: 20210430, status: 05)

    expect(ReceivedCharge.sum).to eq(22345)
  end
end