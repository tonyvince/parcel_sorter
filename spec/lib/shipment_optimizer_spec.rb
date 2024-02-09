require_relative "../../lib/shipment_optimizer"
require_relative "../../lib/shipment"

RSpec.describe ShipmentOptimizer do
  let(:shipment_optimizer) { described_class.new }

  let(:parcel_small) { {parcel_ref: "P1", client_name: "Client A", weight: 100} }
  let(:parcel_medium) { {parcel_ref: "P2", client_name: "Client A", weight: 500} }
  let(:parcel_large) { {parcel_ref: "P3", client_name: "Client B", weight: 2000} }

  describe "#add_parcels_from_client" do
    context "when adding parcels that require multiple shipments due to weight limit" do
      it "creates multiple optimized shipments" do
        shipment_optimizer.add_parcels_from_client("Client A", [parcel_small, parcel_medium])
        shipment_optimizer.add_parcels_from_client("Client B", [parcel_large])

        expect(shipment_optimizer.shipments.size).to eq(2)
        expect(shipment_optimizer.shipments.first.parcels.size).to eq(2)
        expect(shipment_optimizer.shipments.first.total_weight).to eq(parcel_small[:weight] + parcel_medium[:weight])
        expect(shipment_optimizer.shipments.last.parcels.size).to eq(1)
        expect(shipment_optimizer.shipments.last.total_weight).to eq(parcel_large[:weight])
      end
    end

    context "when adding parcels that can fit into a single shipment" do
      it "creates a single optimized shipment" do
        shipment_optimizer.add_parcels_from_client("Client A", [parcel_small, parcel_medium])
        shipment_optimizer.add_parcels_from_client("Client B", [parcel_small, parcel_medium])
        shipment_optimizer.add_parcels_from_client("Client C", [parcel_small, parcel_medium])
        expect(shipment_optimizer.shipments.size).to eq(1)
      end
    end

    context "when clients parcels can't fit into a single shipment" do
      it "raises error" do
        parcels = Array.new(10) { parcel_medium }
        expect { shipment_optimizer.add_parcels_from_client("Client A", parcels) }.to raise_error(
          ShipmentOptimizer::ParcelsExceedMaxWeightError
        )
      end
    end
  end
end
