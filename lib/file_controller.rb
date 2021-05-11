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
end
