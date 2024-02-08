require_relative '../../lib/shipment_generator'
require_relative '../../lib/shipment'

RSpec.describe ShipmentGenerator do
  let(:shipment_generator) { described_class.new }

  let(:parcel_small) { { parcel_ref: 'P1', client_name: 'Client A', weight: 100 } }
  let(:parcel_medium) { { parcel_ref: 'P2', client_name: 'Client A', weight: 500 } }
  let(:parcel_large) { { parcel_ref: 'P3', client_name: 'Client B', weight: 2000 } }

  describe '#add_parcels_from_client' do
    context 'when adding parcels that fit within a single shipment' do
      it 'creates one shipment for all parcels from the same client' do
        shipment_generator.add_parcels_from_client('Client A', [parcel_small, parcel_medium])

        expect(shipment_generator.shipments.size).to eq(1)
        expect(shipment_generator.shipments.first.parcels.size).to eq(2)
        expect(shipment_generator.shipments.first.total_weight).to eq(parcel_small[:weight] + parcel_medium[:weight])
      end
    end

    context 'when adding parcels that require multiple shipments due to weight limit' do
      it 'creates multiple shipments for a single client' do
        parcels = Array.new(5) { parcel_large } # Total weight would exceed the limit of a single shipment
        shipment_generator.add_parcels_from_client('Client B', parcels)

        expect(shipment_generator.shipments.size).to eq 5
        all_parcels = shipment_generator.shipments.flat_map(&:parcels)
        expect(all_parcels).to match_array(parcels)
      end
    end
  end
end
