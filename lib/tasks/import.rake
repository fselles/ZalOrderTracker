require 'nokogiri'
require 'fileutils'

namespace :import do
  desc "Importeer Drukwerkdeal xml bestanden"
  task dwdxml: :environment do

    # Alle bestanden ophalen uit de directory
    # Dir["#{Rails.root}/public/xml/*.xml"].each do |file|
    Dir["/smbshare/xml_input/*.xml"].each do |file|
    # Inhoud xml bestand parsen in variabele doc
    doc = Nokogiri::XML(File.read(file))
    # Xml structuur uitlezen met xpath vanaf root niveau en in lokale variabele record stoppen
      orderdetail = doc.xpath("/").each do |record|
        order = Order.create(
        :customer => "DWD",
        :order_number => record.at('//@MIS_ID'),
        :despatch_date => record.at('//@ToBeShipped'),
        :status => "nieuw" )

        item = order.items.new(
        :article_number => record.at('//@ID'),
        :article_description => record.at('//@Description'),
        :price => record.at('//@PurchasePrice'),
        :quantity => record.at('//@RequiredQuantity'),
        :hrpdf_url => record.at('//@DownloadUrl') )
        item.save

        shipping = order.shippings.new(
        :carrier=> record.at('//@serviceType'),
        :shipping_date => record.at('//@ToBeShipped') )
        shipping.save
      end
    FileUtils.rm(file)
    end
  end
end
