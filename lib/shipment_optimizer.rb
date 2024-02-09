class ShipmentOptimizer
  attr_reader :shipments

  def initialize
    @shipments = []
  end

  def add_parcels_from_client(parcels)
    unless add_parcel_to_existing_shipment(parcels)
      create_new_shipment(parcels)
    end
  end

  private

  def add_parcel_to_existing_shipment(parcels)
    shipments.each do |shipment|
      return true if shipment.add_parcels(parcels)
    end
    false
  end

  def create_new_shipment(parcels)
    shipment = Shipment.new
    shipment.add_parcels(parcels)
    shipments << shipment
  end
end
