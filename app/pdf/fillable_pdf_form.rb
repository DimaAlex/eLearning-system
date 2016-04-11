class FillablePdfForm

  attr_writer :template_path
  attr_reader :attributes

  def initialize(course)
    @course = course
    fill_out
  end

  def export(output_file_path=nil)
    output_path = output_file_path || "#{Rails.root}/public/pdfs/#{SecureRandom.uuid}.pdf" # make sure tmp/pdfs exists
    begin
      pdftk.fill_form template_path, output_path, attributes
    rescue PdfForms::PdftkError => e
      pdftk.fill_form default_template, output_path, attributes
    end
      output_path
  end

  def get_field_names
    pdftk.get_field_names template_path
  end

  def template_path
    @template_path = "#{Rails.root}/public/system/courses/certificate_templates/000/000/0#{@course.id}/original/#{self.class.name.gsub('Pdf', '').underscore}.pdf" # makes assumption about template file path unless otherwise specified
  end

  def default_template
    @template_path = "#{Rails.root}/public/system/#{self.class.name.gsub('Pdf', '').underscore}.pdf" # makes assumption about template file path unless otherwise specified
  end

  protected

  def attributes
    @attributes ||= {}
  end

  def fill(key, value)
    attributes[key.to_s] = value
  end

  def pdftk
    @pdftk ||= PdfForms.new(ENV['PDFTK_PATH'] || '/usr/local/bin/pdftk') # On my Mac, the location of pdftk was different than on my linux server.
  end

  def fill_out
    raise 'Must be overridden by child class'
  end

end