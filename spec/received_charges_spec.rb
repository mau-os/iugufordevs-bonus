require 'spec_helper'

RSpec.describe ReceivedCharge do
  it 'return all received charges' do
    ReceivedCharge.clear
    a = []
    a << ReceivedCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO', payment_date: 20210510)
    a << ReceivedCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO', payment_date: 20210430)
    a << ReceivedCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO', payment_date: 20210312)

    expect(ReceivedCharge.all).to eq(a)
  end

  it 'return all payment methods' do
    ReceivedCharge.clear

    ReceivedCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO', payment_date: 20210510)
    ReceivedCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO', payment_date: 20210430)
    ReceivedCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO', payment_date: 20210312)

    expect(ReceivedCharge.all_payment_methods).to eq(['BOLETO', 'CARTAO'])
  end

  it 'return received charges by payment methods' do
    ReceivedCharge.clear

    a = []
    ReceivedCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO', payment_date: 20210510)
    a << ReceivedCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO', payment_date: 20210312)
    ReceivedCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO', payment_date: 20210430)
    a << ReceivedCharge.new(token: 'g164674h', expiration_date: 20210505, amount: 10505, payment_method: 'CARTAO', payment_date: 20210512)

    expect(ReceivedCharge.list_by_payment_method('CARTAO')).to eq(a)
  end

  it 'return number of received charges by payment methods' do
    ReceivedCharge.clear

    ReceivedCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO', payment_date: 20210510)
    ReceivedCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO', payment_date: 20210430)
    ReceivedCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO', payment_date: 20210312)

    expect(ReceivedCharge.count_by_payment_method('BOLETO')).to eq(2)
  end

  it 'return sum of received charges by payment method' do
    ReceivedCharge.clear

    ReceivedCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO', payment_date: 20210510)
    ReceivedCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO', payment_date: 20210430)
    ReceivedCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO', payment_date: 20210312)

    expect(ReceivedCharge.sum_by_payment_method('BOLETO')).to eq(22345)
  end
end