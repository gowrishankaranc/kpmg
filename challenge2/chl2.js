const fetch = require('node-fetch');

async function queryInstanceMetadata() {
  const metadataEndpoint = 'http://169.254.169.254/metadata/instance?api-version=2021-02-01';

  const headers = {
    'Metadata': 'true'
  };

  try {
    const response = await fetch(metadataEndpoint, { headers });
    if (response.ok) {
      const metadata = await response.json();
      // Access the metadata properties
      console.log('Instance ID:', metadata.compute.vmId);
      console.log('Subscription ID:', metadata.compute.subscriptionId);
      console.log('Resource Group:', metadata.compute.resourceGroupName);
      // ...
    } else {
      console.log('Failed to retrieve instance metadata. Status code:', response.status);
    }
  } catch (error) {
    console.log('An error occurred while querying instance metadata:', error.message);
  }
}

queryInstanceMetadata();
