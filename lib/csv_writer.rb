class CsvWriter
  def self.write(shipments, output_path)
    CSV.open(output_path, "wb") do |csv|
      csv << ["parcel_ref", "client_name", "weight", "shipment_id"]
      shipment_id = 0
      shipments.each do |shipment|
        shipment_id += 1
        shipment_id_str = "SHIPMENT-#{shipment_id}"
        shipment.parcels.each do |parcel|
          csv << [parcel[:parcel_ref], parcel[:client_name], parcel[:weight], shipment_id_str]
        end
        puts "Shipment #{shipment_id_str} created with #{shipment.parcels.size} parcels " \
             "with weight #{shipment.total_weight} and " \
             "remaining capacity #{shipment.remaining_weight_capacity}"
      end
    end
  end
end
