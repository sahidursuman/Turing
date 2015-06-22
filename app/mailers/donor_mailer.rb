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
    
    # Annotate PDF with details
    pdf.pad_top(50) do 
      pdf.text "Dear #{@computer.donor.donor_name},"
    end
    pdf.move_down 6
    pdf.text "Please print out this page and cut along the dotted lines."
    pdf.move_down 5
    pdf.text "The barcode uniquely identifies your computer on our system and should be sellotaped onto the top of your computer's case."
    pdf.move_down 5
    pdf.text "The address label can be used for the outside of your packaging for shipping purposes."
    pdf.move_down 30
    pdf.dash( 4, :space => 3)
    pdf.stroke_horizontal_line 0, 530#, :at => 800
    pdf.move_down 30
    pdf.font_size 16
    @computer.hub.hub_fao.split(",").each do |e|
      pdf.text "#{e}"
      pdf.move_down  5
    end
    @computer.hub.hub_location.split(",").each do |e|
      pdf.text "#{e}"
      pdf.move_down 5
    end
    pdf.move_down 25
    pdf.dash( 4, :space => 3)
    pdf.stroke_horizontal_line 0, 530#, :at => 800
    pdf.move_down 30
    pdf.font_size 12
    pdf.text "Your Turing Track ID is ##{@computer.turingtrack} and is identified by us using this barcode. Please stick this section onto your computer."
    pdf.move_down 140
     pdf.dash( 4, :space => 3)
    pdf.stroke_horizontal_line 0, 530#, :at => 800
    pdf_barcode.annotate_pdf(pdf, { :x => 140, :y => 145, :xdim => 2, :height => 100 } )
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
