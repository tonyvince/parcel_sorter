require "csv"

class ParcelLoader
  attr_reader :parcels

  def initialize(file_path)
    @file_path = file_path
    @parcels = []
  end

  def load_and_sort_parcels
    CSV.foreach(@file_path, headers: true) do |row|
      @parcels << {parcel_ref: row["parcel_ref"], client_name: row["client_name"], weight: row["weight"].to_f}
    end
    # sort parcels by weight in descending order (heaviest first)
    # this becomes handy later on when BFD algorithm is implemented
    @parcels.sort_by! { |parcel| -parcel[:weight] }
  end
end
