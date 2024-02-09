class Shipment
  attr_reader :parcels, :total_weight

  # TODO: use config file instead of hardcoding this value
  MAX_WEIGHT = 2311 # adjust maximum weight as needed here in this constant

  def initialize
    @parcels = []
    @total_weight = 0
  end

  def add_parcels(parcels)
    parcel_weight = parcels.sum { |parcel| parcel[:weight] }
    return false unless can_add_parcels?(parcel_weight)

    @parcels += parcels
    @total_weight += parcel_weight
    true
  end

  def remaining_weight_capacity
    MAX_WEIGHT - @total_weight
  end

  private

  def can_add_parcels?(parcel_weight)
    @total_weight + parcel_weight <= MAX_WEIGHT
  end
end
