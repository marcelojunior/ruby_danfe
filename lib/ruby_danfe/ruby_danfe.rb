module RubyDanfe
  def self.generate(pdf_filename, xml_filename, type = :danfe)
    xml_string = File.new(xml_filename)
    render_file(pdf_filename, xml_string, type)
  end

  def self.render(xml_string, type = :danfe)
    pdf = generatePDF(xml_string, type)
    pdf.render
  end

  def self.render_file(pdf_filename, xml_string, type = :danfe)
    pdf = generatePDF(xml_string, type)
    pdf.render_file pdf_filename
  end

  private
  def self.generatePDF(xml_string, type = :danfe)
    xml = XML.new(xml_string)

    if type == :danfe
      generator = DanfeGenerator.new(xml)
    elsif type == :dacte
      generator = DacteGenerator.new(xml)
    elsif type == :danfse
      generator = DanfseGenerator.new(xml)
    end

    pdf = generator.generatePDF
    pdf
  end
end
