class ShipmentOptimizer
  def initialize(file_path)
    @loader = ParcelLoader.new(file_path)
  end

  def optimize
    @loader.load_and_sort_parcels
    shipment_generator = ShipmentGenerator.new
    parcels_by_client = @loader.parcels.group_by { |parcel| parcel[:client_name] }
    parcels_by_client.each do |client, parcels|
      shipment_generator.add_parcels_from_client(client, parcels)
    end
    shipment_generator.shipments
  end
end
