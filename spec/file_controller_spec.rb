require 'spec_helper'

RSpec.describe FileController do
  it 'create file with header' do
    OpenCharge.clear

    OpenCharge.new(token: 'a123456b', expiration_date: 20210503, amount: 12345, payment_method: 'BOLETO')
    OpenCharge.new(token: 'c654335d', expiration_date: 20210405, amount: 10000, payment_method: 'BOLETO')
    OpenCharge.new(token: 'e166588f', expiration_date: 20210223, amount: 201099, payment_method: 'CARTAO')

    file_name = FileController.start_file('BOLETO')

    expect(File.read("./arquivos/EMISSAO/#{file_name}")).to eq(
            "H00002\n"\
            "Ba123456b20210503        000001234501\n"\
            "Bc654335d20210405        000001000001\n"\
            "F000000000022345")
  end
end