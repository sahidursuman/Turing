# Preview all emails at http://localhost:3000/rails/mailers/donor_mailer
class DonorMailerPreview < ActionMailer::Preview
  
  def thankyou_mail_preview
    DonorMailer.thankyou_email(Computer.first)
  end
  
  def wiped_mail_preview
    DonorMailer.wiped_email(Computer.first)
  end
  
end
