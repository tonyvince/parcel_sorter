require_relative '../../lib/csv_writer'
require_relative '../../lib/shipment'

RSpec.describe CsvWriter do
  let(:output_file_path) { 'spec/fixtures/test_output.csv' }
  let(:shipments) do
    [
      Shipment.new.tap do |shipment|
        shipment.add_parcels([
          { parcel_ref: 'P1', client_name: 'Client A', weight: 100 },
          { parcel_ref: 'P4', client_name: 'Client A', weight: 800 }
        ])
      end,
      Shipment.new.tap do |shipment|
        shipment.add_parcels([{ parcel_ref: 'P2', client_name: 'Client B', weight: 500 }])
      end,
      Shipment.new.tap do |shipment|
        shipment.add_parcels([
          { parcel_ref: 'P3', client_name: 'Client B', weight: 1800 },
          { parcel_ref: 'P5', client_name: 'Client C', weight: 300 }
        ])
      end
    ]
  end

  after do
    File.delete(output_file_path) if File.exist?(output_file_path)
  end

  describe '.write' do
    it 'writes shipments to a CSV file with the correct format' do
      CsvWriter.write(shipments, output_file_path)

      written_data = CSV.read(output_file_path, headers: true).map(&:to_h)

      # 3 shipments, 5 parcels
      expect(written_data.size).to eq(5)
      expect(written_data[0]['client_name']).to eq('Client A')
      expect(written_data[0]['weight']).to eq('100')
      expect(written_data[0]['shipment_id']).to eq('SHIPMENT-1')
      expect(written_data[-1]['client_name']).to eq('Client C')
      expect(written_data[-1]['weight']).to eq('300')
      expect(written_data[-1]['shipment_id']).to eq('SHIPMENT-3')
    end
  end
end
