require 'nokogiri'
require 'fileutils'

namespace :import do
  desc "Importeer Drukwerkdeal xml bestanden"
  task dwdxml: :environment do

    # Alle bestanden ophalen uit de directory
    Dir["#{Rails.root}/public/xml/*.xml"].each do |file|
    # Inhoud xml bestand parsen in variabele doc
    doc = Nokogiri::XML(File.read(file))
    # Xml structuur uitlezen met xpath vanaf root niveau en in lokale variabele record stoppen
      doc.xpath("/").each do |row|
        Order.create(
        :customer => "DWD",
        :order_number => row.at('//@MIS_ID'),
        :despatch_date => row.at('//@ToBeShipped'),
        :status => "new" )
      end
    # FileUtils.rm(file)
    end
  end
end