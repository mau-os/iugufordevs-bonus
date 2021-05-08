require_relative 'charge'

class FileController
  def self.start_file(payment_method)
    file_name = "#{Time.now.strftime("%Y%m%d")}-#{payment_method}_EMISSAO.txt"
    file = File.new("./arquivos/EMISSAO/#{file_name}", 'w+')
    file.write("H#{"%05d" % Charge.count_by_payment_method(payment_method)}" + $/)
    file.close
    file_name
  end
end
