class ImportController < ApplicationController


  def importxml
      # Alle bestanden ophalen uit de directory
    Dir["#{Rails.root}/public/xml/*.xml"].each do |file|
      # Inhoud xml bestand parsen in variabele doc
      doc = Nokogiri::XML(File.read(file))
      # Xml structuur uitlezen met xpath vanaf root niveau en in lokale variabele record stoppen
      doc.xpath("/").each do |row|
        # ordernumber =  row.xpath("//@MIS_ID")

        Order.create(
        :customer => "DWD",
        :order_number => row.at('//@MIS_ID'),
        :despatch_date => row.at('//@ToBeShipped'),
        :status => "new" )
      end
    end
    respond_to do |format|
        format.html { redirect_to root_url, notice: "File has been processed successfully" }
        format.json { head :no_content }
      end
  end
end
