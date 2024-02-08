class Shipment
  attr_reader :parcels, :total_weight

  # TODO: use config file instead of hardcoding this value
  MAX_WEIGHT = 2311 # adjust maximum weight as needed here in this constant

  def initialize
    @parcels = []
    @total_weight = 0
  end

  def add_parcel(parcel)
    return false unless can_add_parcel?(parcel)

    @parcels << parcel
    @total_weight += parcel[:weight]
    true
  end

  private

  def can_add_parcel?(parcel)
    @total_weight + parcel[:weight] <= MAX_WEIGHT
  end
end
