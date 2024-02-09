require_relative "../../lib/shipment"

RSpec.describe Shipment do
  describe "#initialize" do
    it "starts with an empty parcel list and zero total weight" do
      shipment = Shipment.new
      expect(shipment.parcels).to be_empty
      expect(shipment.total_weight).to eq(0)
    end
  end

  describe "#add_parcels" do
    let(:parcel) { {parcel_ref: "P1", client_name: "Client A", weight: 100} }
    let(:heavy_parcel) { {parcel_ref: "P2", client_name: "Client B", weight: Shipment::MAX_WEIGHT + 1} }

    context "when adding a parcel within the weight limit" do
      it "successfully adds the parcel" do
        shipment = Shipment.new
        expect(shipment.add_parcels([parcel])).to be true
        expect(shipment.parcels).to include(parcel)
        expect(shipment.total_weight).to eq(parcel[:weight])
      end
    end

    context "when adding a parcel that exceeds the weight limit" do
      it "does not add the parcel" do
        shipment = Shipment.new
        expect(shipment.add_parcels([heavy_parcel])).to be false
        expect(shipment.parcels).not_to include(heavy_parcel)
        expect(shipment.total_weight).to eq(0)
      end
    end
  end

  describe "#remaining_weight_capacity" do
    it "correctly calculates the remaining weight capacity of the shipment" do
      shipment = Shipment.new
      parcel = {parcel_ref: "P1", client_name: "Client A", weight: 500}
      shipment.add_parcels([parcel])

      expected_remaining_capacity = Shipment::MAX_WEIGHT - parcel[:weight]
      expect(shipment.remaining_weight_capacity).to eq(expected_remaining_capacity)
    end
  end
end
