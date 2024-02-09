require_relative '../../lib/parcel_loader'
require_relative '../../lib/parcel_manager'
require_relative '../../lib/shipment_optimizer'
require_relative '../../lib/shipment'

RSpec.describe ParcelManager do
  let(:input_file_path) { 'spec/fixtures/test_input.csv' }

  before do
    CSV.open(input_file_path, 'wb') do |csv|
      csv << ['parcel_ref', 'client_name', 'weight']
      csv << ['P1', 'Client A', 100]
      csv << ['P2', 'Client B', 411]
      csv << ['P3', 'Client B', 1900]
      csv << ['P4', 'Client A', 800]
      csv << ['P5', 'Client C', 300]
    end
  end

  after do
    File.delete(input_file_path) if File.exist?(input_file_path)
  end

  describe '#optimize' do
    it 'optimizes parcel distribution into shipments' do
      optimizer = ParcelManager.new(input_file_path)
      optimized_shipments = optimizer.optimize


      total_weight_limit = Shipment::MAX_WEIGHT # 2311 kg
      total_parcel_count = 5

      total_assigned_parcels = optimized_shipments.sum { |shipment| shipment.parcels.size }
      expect(total_assigned_parcels).to eq(total_parcel_count)

      # Verify that no shipment exceeds the weight limit
      optimized_shipments.each do |shipment|
        expect(shipment.total_weight).to be <= total_weight_limit
      end
      # - Client A's parcels to be in one shipment (because their combined weight is 900, which is under the limit)
      # - Client B's parcels in a separate shipments due to the large parcel weight
      # - Client C's parcel fitting into Client A's shipment
      # Assuming an efficient optimization, there should be 2 shipments based on the sample data
      expect(optimized_shipments.size).to eq(2)
    end
  end
end
