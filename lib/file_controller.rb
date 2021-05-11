require_relative 'charge'

class FileController
  def self.start_file(payment_method)
    file_name = "#{Time.now.strftime("%Y%m%d")}-#{payment_method}_EMISSAO.txt"
    file = File.new("./arquivos/EMISSAO/#{file_name}", 'w+')
    file.write("H#{"%05d" % OpenCharge.count_by_payment_method(payment_method)}" + $/)
    OpenCharge.list_by_payment_method(payment_method).each do |charge|
      file.write("B#{charge.to_file}" + $/)
    end
    file.write("F#{"%015d" % OpenCharge.sum_by_payment_method(payment_method)}")
    file.close
    file_name
  end

  def self.read_returns
    list_return_files.each do |file_name|
      ReceivedCharge.clear
      validates(file_name)
    end
  end

  def self.validates(file_name)
    registers_quantity = 0
    counted_registers = 0
    registers_value = 0
    file = File.readlines(file_name).each do |line|
      case line[0]
      when 'B'
        counted_registers += 1
        ReceivedCharge.new(
          token: line[1..8],
          expiration_date: line[9..16].to_i,
          payment_date: line[17..24].to_i,
          amount: line[25..34].to_i,
          status: line[35..36].to_i
        )
      when 'H'
        registers_quantity = line[1..5].to_i
      when 'F'
        registers_value = line[1..15].to_i
      end
    end
    if counted_registers != registers_quantity || ReceivedCharge.sum != registers_value
      ReceivedCharge.clear
      return false
    end
    true
  end

  def self.list_return_files
    Dir['./arquivos/RETORNO/*_RETORNO.txt']
  end
end
