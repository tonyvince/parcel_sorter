require_relative "lib/parcel_loader"
require_relative "lib/shipment_optimizer"
require_relative "lib/parcel_manager"
require_relative "lib/csv_writer"
require_relative "lib/shipment"

input_file_path = File.join(File.dirname(__FILE__), "data", "input.csv")
output_file_path = File.join(File.dirname(__FILE__), "data", "output.csv")

parcel_manager = ParcelManager.new(input_file_path)
optimized_shipments = parcel_manager.optimize
CsvWriter.write(optimized_shipments, output_file_path)

puts "Shipment optimization complete. Results saved to #{output_file_path}"
