require 'spec_helper'

RSpec.describe Charge do
  it 'remove special chars' do
    a = Charge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'cartão de crédito')

    expect(a.payment_method).to eq('CARTAO_DE_CREDITO')
  end
end