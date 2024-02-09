# Orchestrates the process of loading parcels and optimizing their distribution into shipments.
# Utilizes ParcelLoader to fetch parcel data and ShipmentOptimizer to allocate parcels efficiently.
class ParcelManager
  def initialize(file_path)
    @loader = ParcelLoader.new(file_path)
    @shipment_optimizer = ShipmentOptimizer.new
  end

  # Optimizes parcel distribution into shipments to minimize the total number and weight distribution.
  # @return [Array<Shipment>] Array of optimized shipments.
  def optimize
    @loader.load_parcels
    # sort parcels by weight in descending order (heaviest first)
    # this becomes handy later on when BFD algorithm is applied
    parcels_by_client = @loader.parcels.group_by { |parcel| parcel[:client_name] }.sort_by do |client, parcels|
      -parcels.sum { |parcel| parcel[:weight] }
    end
    parcels_by_client.each do |_client, parcels|
      shipment_optimizer.add_parcels_from_client(parcels)
    end
    shipment_optimizer.shipments
  end

  private

  attr_reader :shipment_optimizer
end
