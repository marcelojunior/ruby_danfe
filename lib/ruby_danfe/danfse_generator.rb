# coding: utf-8
module RubyDanfe
  class DanfseGenerator
    def initialize(xml)
      @xml = xml
      @pdf = Document.new
      @vol = 0
    end

    def generatePDF
      @pdf.repeat :all do
        render_regua
        render_cabecalho
        render_prestador
        render_tomador
        render_servicos
        render_valor_total
      end

      @pdf
    end

    private

    # (h, w, x, y, title = '', info = '', options = {})
    
    def render_regua
      (1..21).each do |n|
        @pdf.ibox 1.00, n, n - 1, 0.50, '', n.to_s
        @pdf.ibox 0.25, 0.005, (n - 1) + 0.50, 1.25
      end  
    end

    def render_cabecalho
      @pdf.ibox 2.50, 13.50, 1.50, 1.50, 'PREFEITURA'
      @pdf.ibox 0.83, 4.00, 15.00, 1.50, 'NÚMERO DA NOTA', @xml['InfNfse/Numero'], {:align => :center}
      @pdf.ibox 0.83, 4.00, 15.00, 2.33, 'DATA E HORA DA EMISSÃO', Helper.timestamp(@xml['InfNfse/DataEmissao']), {:align => :center}
      @pdf.ibox 0.83, 4.00, 15.00, 3.17, 'CÓDIGO DE VERIFICAÇÃO', @xml['InfNfse/CodigoVerificacao'], {:align => :center}
    end

    def render_prestador
      @pdf.ibox 2.50, 17.50, 1.50, 4, 'PRESTADOR DE SERVIÇOS'
      @pdf.itext 0.5, 3, 2, 4.5, 'Nome/Razão Social:'
      @pdf.itext 0.5, 6, 4.2, 4.5, @xml['PrestadorServico/RazaoSocial'], :bold
      @pdf.itext 0.5, 2, 2, 5, 'CPF/CNPJ:'
      @pdf.itext 0.5, 3, 3.2, 5, Helper.cnpj(@xml['IdentificacaoPrestador/Cnpj']), :bold if @xml['IdentificacaoPrestador/Cnpj'] != ''
      @pdf.itext 0.5, 2, 3.2, 5, Helper.cpf(@xml['IdentificacaoPrestador/Cpf']), :bold if @xml['IdentificacaoPrestador/Cpf'] != ''
      @pdf.itext 0.5, 3, 7, 5, 'Incrição Municipal:'
      @pdf.itext 0.5, 3, 9, 5, @xml['IdentificacaoPrestador/InscricaoMunicipal'], :bold
      @pdf.itext 0.5, 3, 2, 5.5, 'Endereço:'
      @pdf.itext 0.5, 16, 3.2, 5.5, "#{@xml['PrestadorServico/Endereco/Endereco']} - " +
                               "#{@xml['PrestadorServico/Endereco/Numero']} - " + 
                               "#{@xml['PrestadorServico/Endereco/Bairro']} - " + 
                               'CEP: ' + Helper.cep(@xml['PrestadorServico/Endereco/Cep']), :bold
      @pdf.itext 0.5, 6, 2, 6, 'Município: #### FALTA IMPLEMENTAR A API ###'
      # http://www.ibge.gov.br/home/geociencias/areaterritorial/area.php?nome=&codigo=4204202&submit.x=52&submit.y=8
    end


    def render_tomador
      @pdf.ibox 2.50, 17.50, 1.50, 6.5, 'TOMADOR DE SERVIÇOS'
      @pdf.itext 0.5, 3, 2, 7, 'Nome/Razão Social:'
      @pdf.itext 0.5, 6, 4.2, 7, @xml['TomadorServico/RazaoSocial'], :bold
      @pdf.itext 0.5, 2, 2, 7.5, 'CPF/CNPJ:'
      @pdf.itext 0.5, 3, 3.2, 7.5, Helper.cnpj(@xml['IdentificacaoTomador/CpfCnpj/Cnpj']), :bold if @xml['IdentificacaoTomador/CpfCnpj/Cnpj'] != ''
      @pdf.itext 0.5, 2, 3.2, 7.5, Helper.cpf(@xml['IdentificacaoTomador/CpfCnpj/Cpf']), :bold if @xml['IdentificacaoTomador/CpfCnpj/Cpf'] != ''
      @pdf.itext 0.5, 3, 7, 7.5, 'Incrição Municipal:'
      @pdf.itext 0.5, 3, 9, 7.5, @xml['IdentificacaoTomador/InscricaoMunicipal'], :bold
      @pdf.itext 0.5, 3, 2, 8, 'Endereço:'
      @pdf.itext 0.5, 16, 3.2, 8, "#{@xml['TomadorServico/Endereco/Endereco']} - " +
                               "#{@xml['TomadorServico/Endereco/Numero']} - " + 
                               "#{@xml['TomadorServico/Endereco/Bairro']} - " + 
                               'CEP: ' + Helper.cep(@xml['TomadorServico/Endereco/Cep']), :bold
      @pdf.itext 0.5, 6, 2, 8.5, 'Município: #### FALTA IMPLEMENTAR A API ###'      
      # http://www.ibge.gov.br/home/geociencias/areaterritorial/area.php?nome=&codigo=4204202&submit.x=52&submit.y=8
    end

    def render_servicos      
      @pdf.ibox 6, 17.50, 1.50, 9, 'DISCRIMINAÇÃO DOS SERVIÇOS'
      @pdf.itext 5, 17, 2, 9.5, @xml['Servico/Discriminacao']
    end

    def render_valor_total
      @pdf.ibox 0.5, 17.50, 1.50, 15
      @pdf.ititle 0.5, 17.50, 2, 15.1, 'VALOR TOTAL DA NOTA = R$ ' + Helper.numerify(@xml['Servico/Valores/ValorServicos']), :center
    end


  end
end
