class DonorMailer < ActionMailer::Base
  
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/html_outputter'

  default from: "recycle@theturingtrust.co.uk"
  
  def thankyou_email(computer)
    @computer  = computer
    @donor = computer.donor
    @barcode = Barby::Code128B.new(computer.turingtrack)
    @barcode_for_html = Barby::HtmlOutputter.new(@barcode)
    #email_with_name = %("#{@donor.donor_name}" <#{@donor.donor_email}>)
    #mail(to: email_with_name, subject: 'Your donation to The Turing Trust')
    mail(to: @donor.donor_email, subject: 'Your donation to The Turing Trust')
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
