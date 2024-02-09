# Represents a single shipment, tracking parcels, their total weight, and ensuring the weight
# does not exceed a predefined maximum.
class Shipment
  attr_reader :parcels, :total_weight

  # TODO: use config file instead of hardcoding this value
  MAX_WEIGHT = 2311 # adjust maximum weight as needed here in this constant

  def initialize
    @parcels = []
    @total_weight = 0
  end

  # Adds parcels to the shipment if the resulting total weight does not exceed MAX_WEIGHT.
  # @param parcels [Array<Hash>] Parcels to be added.
  # @return [Boolean] True if the parcels were added successfully, false otherwise.
  def add_parcels(parcels)
    parcel_weight = parcels.sum { |parcel| parcel[:weight] }
    return false unless can_add_parcels?(parcel_weight)

    @parcels += parcels
    @total_weight += parcel_weight
    true
  end

  # Calculates the remaining weight capacity of the shipment.
  # @return [Float] Remaining weight capacity.
  def remaining_weight_capacity
    MAX_WEIGHT - @total_weight
  end

  private

  def can_add_parcels?(parcel_weight)
    @total_weight + parcel_weight <= MAX_WEIGHT
  end
end
