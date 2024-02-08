class ShipmentGenerator
  def initialize
    @client_shipments = {}
  end

  def add_parcels_from_client(client, parcels)
    parcels.each do |parcel|
      unless add_parcel_to_existing_shipment(client, parcel)
        create_new_shipment_for_client(client, parcel)
      end
    end
  end

  def shipments
    @client_shipments.values.flatten
  end

  private

  def add_parcel_to_existing_shipment(client, parcel)
    (@client_shipments[client] ||= []).each do |shipment|
      return true if shipment.add_parcel(parcel)
    end
    false
  end

  def create_new_shipment_for_client(client, parcel)
    shipment = Shipment.new
    shipment.add_parcel(parcel)
    (@client_shipments[client] ||= []) << shipment
  end
end
