# Manages the optimization of parcels into shipments, ensuring that the total weight of each shipment
# does not exceed the maximum allowable weight, and minimizing the total number of shipments.
class ShipmentOptimizer
  attr_reader :shipments

  class ParcelsExceedMaxWeightError < StandardError; end

  def initialize
    @shipments = []
  end

  # Adds parcels from a client into existing or new shipments based on optimization criteria.
  # @param client [String] Name of the client.
  # @param parcels [Array<Hash>] Array of parcels to be added.
  def add_parcels_from_client(client, parcels)
    unless add_parcel_to_existing_shipment(parcels)
      create_new_shipment(client, parcels)
    end
  end

  private

  def add_parcel_to_existing_shipment(parcels)
    shipments.each do |shipment|
      return true if shipment.add_parcels(parcels)
    end
    false
  end

  def create_new_shipment(client, parcels)
    shipment = Shipment.new
    success = shipment.add_parcels(parcels)
    raise ParcelsExceedMaxWeightError, "Total parcel weight of #{client} exceeds Max limit" unless success
    shipments << shipment
  end
end
