# Azure Instance Metadata Retrieval

This script demonstrates how to retrieve metadata from Azure instances using the Azure Instance Metadata Service (IMDS) in Python.

## Prerequisites

- Python 3.x
- `requests` library (can be installed using `pip install requests`)

## Usage

1. Install the required libraries by running the following command:

   ```bash
   pip install requests
   ```

2. Copy and paste the code into a Python file (e.g., `azure_vm_metadata.py`).

3. Run the script using the following command:

   ```bash
   azure_vm_metadata.py
   ```

## Explanation

1. The script uses the `requests` library to send HTTP requests to the Azure Instance Metadata Service.
2. The `get_metadata` function is responsible for retrieving metadata from a specific path in the instance metadata service. It appends the path to the base metadata URL and sends a GET request with the `Metadata` header set to `'true'`.
3. The `print_metadata` function iterates over the metadata dictionary and prints each key-value pair.
4. In the `main` function, the script retrieves the root metadata by calling `get_metadata("/")` and then prints the metadata using `print_metadata`.

Note: Ensure that the script is running within an Azure instance, as the Azure Instance Metadata Service is only available within Azure instances.