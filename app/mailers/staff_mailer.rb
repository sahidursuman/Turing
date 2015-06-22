class StaffMailer < ActionMailer::Base
  
  require 'barby'
  require 'barby/barcode/code_128'
  require 'barby/outputter/prawn_outputter'
  
  default from: "recycle@theturingtrust.co.uk"
  
  def barcode_index_email(computers, staff)
    
    #@computers = Computer.barcode_search( params[:barcode_upper], params[:barcode_lower] ).order("created_at DESC")
    @computers = computers
    pdf = Prawn::Document.new
    i = 1 # Barcode Counter
    y = 620 # Height on Page Barcode is Appended
    
    @computers.each do |computer|
      barcode = Barby::Code128B.new(computer.turingtrack)
      pdf_barcode = Barby::PrawnOutputter.new(barcode)
      
      if i % 2 == 1
        pdf_barcode.annotate_pdf(pdf, { :x => 50, :y => y, :xdim => 1.5, :height => 70 } )
        pdf.draw_text "#{computer.turingtrack}", :at => [115, y + 75]
      else
        pdf_barcode.annotate_pdf(pdf, { :x => 300, :y => y, :xdim => 1.5, :height => 70 } )
        pdf.draw_text "#{computer.turingtrack}", :at => [365, y + 75]
        y -= 120
      end
      
      if i % 12 == 0 
        pdf.start_new_page
        y = 620
      end
      
      i += 1
    end  
    
    pdf.render_file "#{Rails.root}/app/assets/images/barcode_index.pdf"
    
    attachments["barcode_index.pdf"] = File.read("#{Rails.root}/app/assets/images/barcode_index.pdf")
    mail(to: "#{staff.staff_email}", subject: "Barcode Index PDF for Printing")
  
  end
  
end
