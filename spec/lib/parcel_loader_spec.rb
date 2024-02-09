require_relative "../../lib/parcel_loader"

RSpec.describe ParcelLoader do
  let(:test_csv_path) { "spec/fixtures/test_parcels.csv" }
  let(:parcel_loader) { ParcelLoader.new(test_csv_path) }

  before do
    # Sample content for a test CSV file
    CSV.open(test_csv_path, "wb") do |csv|
      csv << ["parcel_ref", "client_name", "weight"]
      csv << ["P1", "Client A", 500]
      csv << ["P2", "Client B", 1500]
      csv << ["P3", "Client C", 300]
    end
  end

  after do
    File.delete(test_csv_path) if File.exist?(test_csv_path)
  end

  describe "#load_parcels" do
    it "loads parcels from a CSV file" do
      parcel_loader.load_parcels

      expect(parcel_loader.parcels.size).to eq(3)
      expect(parcel_loader.parcels.map { |p| p[:weight] }).to match_array([1500, 500, 300]) # Sorted by weight in descending order
    end
  end
end
