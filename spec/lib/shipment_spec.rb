require_relative '../../lib/shipment'

RSpec.describe Shipment do
  let(:parcel_small) { { parcel_ref: 'P1', client_name: 'Client A', weight: 200 } }
  let(:parcel_large) { { parcel_ref: 'P2', client_name: 'Client B', weight: 2100 } }
  let(:parcel_exceeding) { { parcel_ref: 'P3', client_name: 'Client C', weight: 2312 } } # Exceeds MAX_WEIGHT

  describe '#add_parcel' do
    subject(:shipment) { Shipment.new }

    context 'when adding a parcel within the weight limit' do
      it 'adds the parcel successfully' do
        expect(shipment.add_parcel(parcel_small)).to be true
        expect(shipment.parcels).to include(parcel_small)
        expect(shipment.total_weight).to eq(parcel_small[:weight])
      end
    end

    context 'when adding a parcel that exceeds the weight limit' do
      it 'does not add the parcel' do
        shipment.add_parcel(parcel_large) # Add a large parcel first
        expect(shipment.add_parcel(parcel_exceeding)).to be false
        expect(shipment.parcels).not_to include(parcel_exceeding)
      end
    end

    context 'when the total weight would exceed the limit after adding' do
      it 'prevents the parcel from being added' do
        shipment.add_parcel(parcel_large) # This should be fine
        # This is also fine because the total weight is still within the limit 2311
        expect(shipment.add_parcel(parcel_small)).to be true
        expect(shipment.add_parcel(parcel_exceeding)).to be false
        expect(shipment.parcels).to include(parcel_small)
        expect(shipment.parcels).not_to include(parcel_exceeding)
        expect(shipment.total_weight).to eq(parcel_large[:weight] + parcel_small[:weight])
      end
    end
  end
end
