require 'spec_helper'

RSpec.describe OpenCharge do
  it 'return all open charges' do
    OpenCharge.clear
    a = []
    a << OpenCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    a << OpenCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    a << OpenCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    expect(OpenCharge.all).to eq(a)
  end

  it 'return all payment methods' do
    OpenCharge.clear

    OpenCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    OpenCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    OpenCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    expect(OpenCharge.all_payment_methods).to eq(['BOLETO', 'CARTAO'])
  end

  it 'return open charges by payment methods' do
    OpenCharge.clear

    a = []
    OpenCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    a << OpenCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')
    OpenCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    a << OpenCharge.new(token: 'g164674h', expiration_date: 20210505, amount: 10505, payment_method: 'CARTAO')

    expect(OpenCharge.list_by_payment_method('CARTAO')).to eq(a)
  end

  it 'return number of open charges by payment methods' do
    OpenCharge.clear

    OpenCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    OpenCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    OpenCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    expect(OpenCharge.count_by_payment_method('BOLETO')).to eq(2)
  end

  it 'return sum of open charges by payment method' do
    OpenCharge.clear

    OpenCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    OpenCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    OpenCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    expect(OpenCharge.sum_by_payment_method('BOLETO')).to eq(22345)
  end
end