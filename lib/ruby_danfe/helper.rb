module RubyDanfe
  class Helper
    def self.numerify(number, decimals = 2)
      return "" if !number || number == ""
      int, frac = ("%.#{decimals}f" % number).split(".")
      int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1\.")
      int + "," + frac
    end

    def self.invert(y)
      28.7.cm - y
    end

    # Padrão "2013-12-01T00:00:00-02:00" para dd/mm/yyyy hh:mm:ss
    def self.timestamp(date)
      DateTime.parse(date).strftime('%d/%m/%Y %H:%M:%S')
    end

    # Converte um número (00000000000000) em CNPJ (00.000.000/0000-00)
    # O parâmetro deve ser do tipo string
    def self.cnpj(numero)
      if numero =~ /\./
        numero
      else
        if !numero.empty?    
          numero[2] = ".#{numero[2]}"
          numero[6] = ".#{numero[6]}"
          numero[10] = "/#{numero[10]}"
          numero[15] = "-#{numero[15]}"
          numero
        else
          ''
        end
      end
    end

    # Converte um número (00000000000) em CPF (000.000.000-00)
    # O parâmetro deve ser do tipo string
    def self.cpf(numero)
      if numero =~ /\./
        numero
      else
        if !numero.empty?
          numero[3] = ".#{numero[3]}"
          numero[7] = ".#{numero[7]}"
          numero[11] = "-#{numero[11]}"
          numero
        else
          ''
        end
      end
    end   

    # Converte um número (00000000) em CEP (00000-000)
    # O parâmetro deve ser do tipo string
    def self.cep(numero)
      if numero =~ /\-/
        numero
      else
        if !numero.empty?
          numero[5] = "-#{numero[5]}"
          numero
        else
          ''
        end
      end
    end 

  end
end
