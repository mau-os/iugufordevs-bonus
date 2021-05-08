require 'spec_helper'

RSpec.describe Charge do
  it 'return all charges' do
    Charge.clear
    a = []
    a << Charge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    a << Charge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    a << Charge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    expect(Charge.all).to eq(a)
  end

  it 'remove special chars' do
    Charge.clear
    a = Charge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'cartão de crédito')

    expect(a.payment_method).to eq('CARTAO_DE_CREDITO')
  end

  it 'return all payment methods' do
    Charge.clear

    Charge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    Charge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    Charge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    expect(Charge.all_payment_methods).to eq(['BOLETO', 'CARTAO'])
  end

  it 'return charges by payment methods' do
    Charge.clear

    a = []
    Charge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    a << Charge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')
    Charge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    a << Charge.new(token: 'g164674h', expiration_date: 20210505, amount: 10505, payment_method: 'CARTAO')

    expect(Charge.list_by_payment_method('CARTAO')).to eq(a)
  end

  it 'return number of charges by payment methods' do
    Charge.clear

    Charge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    Charge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    Charge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    expect(Charge.count_by_payment_method('BOLETO')).to eq(2)
  end

  it 'return sum of charges by payment method' do
    Charge.clear

    Charge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    Charge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    Charge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    expect(Charge.sum_by_payment_method('BOLETO')).to eq(22345)
  end
end