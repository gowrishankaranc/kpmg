# Azure Instance Metadata Query (JavaScript)

This repository contains a JavaScript code snippet that demonstrates how to query the metadata of an Azure instance using Node.js. The code sends an HTTP GET request to the Azure Instance Metadata Service (IMDS) endpoint and retrieves various properties of the instance.

## Prerequisites

Before running the code, ensure that you have the following:

- Node.js installed on your system. You can download it from the official [Node.js website](https://nodejs.org).

## Getting Started

1. Clone this repository to your local machine or download the JavaScript file.

2. Open a terminal or command prompt and navigate to the project directory.
 
3. Install the necessary dependencies by running the following command:

   ```shell
   npm install node-fetch

Steps for Run:

1.Open the JavaScript file (query-instance-metadata.js) in a text editor.

2.Optionally, modify the code to access additional or specific metadata properties based on your requirements.

3.Save the file and return to the terminal or command prompt.

4.Execute the JavaScript code by running the following command:
  node query-instance-metadata.js

The code will send a request to the Azure IMDS endpoint and display the retrieved metadata properties in the console.

Notes
The code uses the node-fetch library to make HTTP requests. It is included as a dependency in the package.json file.

Ensure that your Azure instance has access to the IMDS. By default, Azure instances have access to the IMDS endpoint (http://169.254.169.254). If you encounter any issues, ensure that the endpoint address is correct for your environment.

References
Azure Instance Metadata Service (IMDS) Documentation
Node.js Documentation
node-fetch on npm
