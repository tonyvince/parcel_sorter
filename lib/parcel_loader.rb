# Responsible for loading parcel data from a CSV file into a structured format.
# Each parcel is represented as a hash with keys for parcel reference, client name, and weight.
require "csv"

class ParcelLoader
  attr_reader :parcels

  # @param file_path [String] Path to the input CSV file.
  def initialize(file_path)
    @file_path = file_path
    @parcels = []
  end

  def load_parcels
    CSV.foreach(@file_path, headers: true) do |row|
      @parcels << {parcel_ref: row["parcel_ref"], client_name: row["client_name"], weight: row["weight"].to_f}
    end
  end
end
