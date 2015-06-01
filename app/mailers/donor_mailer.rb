class DonorMailer < ActionMailer::Base
  
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/html_outputter'
  require 'barby/outputter/prawn_outputter'

  default from: "recycle@theturingtrust.co.uk"
  
  def thankyou_email(computer)
    @computer  = computer
    @donor = computer.donor
    @barcode = Barby::Code128B.new(computer.turingtrack)
    @barcode_for_html = Barby::HtmlOutputter.new(@barcode)
    
    pdf_barcode = Barby::PrawnOutputter.new(@barcode) 
    pdf = Prawn::Document.new
    pdf_barcode.annotate_pdf(pdf, { :x => 140, :y => 50, :xdim => 2, :height => 100 } )
    pdf.render_file "#{Rails.root}/app/assets/images/barcodes/#{@computer.turingtrack}.pdf"
    
    #email_with_name = %("#{@donor.donor_name}" <#{@donor.donor_email}>)
    #mail(to: email_with_name, subject: 'Your donation to The Turing Trust')

    attachments["#{@computer.turingtrack}-barcode.pdf"] = File.read("#{Rails.root}/app/assets/images/barcodes/#{@computer.turingtrack}.pdf")
    mail(to: @donor.donor_email, subject: "Your donation to The Turing Trust")
  end
  
  def wiped_email(computer)
    @computer  = computer
    @donor = computer.donor
    @wipe = computer.donor
    #email_with_name = %("#{@donor.donor_name}" <#{@donor.donor_email}>)
    #mail(to: email_with_name, subject: 'Your donation has been shipped!')
    mail(to: @donor.donor_email, subject: 'Your donation to The Turing Trust')
  end
  
end
