# Parcel Sorter Application
![workflow](https://github.com/tonyvince/parcel_sorter/actions/workflows/ci.yml/badge.svg)

## Description

The Parcel Sorter Application is designed to optimize the distribution of parcels into shipments based on weight constraints. The goal is to fit parcels into as few shipments as possible, ensuring that each shipment does not exceed a maximum weight limit. The application adheres to the following key requirements:

- a shipment has a maximum weight of 2311 kg;
- one client's parcels may not be in multiple shipments;
- a shipment may contain parcels from multiple clients;
- a single parcel may not be split between shipments;

## Key Algorithms

The application uses the **Best Fit Decreasing (BFD)** algorithm for optimizing parcel distribution. This approach involves sorting parcels in descending order of total weight and then placing each parcel into the best fitting (least remaining weight capacity) shipment, ensuring efficient space utilization and minimizing the number of shipments.

### Prerequisites

- Ruby version 3.2.2
- Bundler for managing gem dependencies

### Setup

1. Clone the repository and navigate into the application directory.
2. Install the required gems by running: `bundle install`

## How to Run the Application

To run the application, execute the following command from the root directory of the project:

To run the application, execute the following command from the root directory of the project:
```
ruby app.rb
```
Ensure that the input CSV file path and output CSV file path are correctly specified in `app.rb`.

### Output

Output should look like this

```
Shipment SHIPMENT-1 created with 201 parcels with weight 2311.0 and remaining capacity 0.0
Shipment SHIPMENT-2 created with 193 parcels with weight 2188.0 and remaining capacity 123.0
Shipment SHIPMENT-3 created with 207 parcels with weight 2262.0 and remaining capacity 49.0
Shipment SHIPMENT-4 created with 212 parcels with weight 2291.0 and remaining capacity 20.0
Shipment SHIPMENT-5 created with 187 parcels with weight 1855.0 and remaining capacity 456.0
Shipment optimization complete. Results saved to ./data/output.csv
```
a csv file will be written to the specified location (data/output.csv if unchanged)

## Run Tests

The application uses RSpec for testing. To run the tests, follow these steps:

1. Navigate to the root directory of the project.
2. Execute the test suite by running: `bundle exec rspec`

## Run Linter

Run linter using `bundle exec standardrb`

## ToDo

- **Add Configuration File**: Implement a configuration file to specify application settings such as the maximum weight limit for shipments and the paths for input and output files, instead of hardcoding these values.
- **Error handling**: Add more error handling and logging


