import json
import subprocess

def query_vm_metadata():
    cmd = 'az vm show -d --ids $(az vm list --query "[].id" -o tsv)'
    output = subprocess.check_output(cmd, shell=True).decode('utf-8')
    vm_metadata = json.loads(output)
    return vm_metadata

if __name__ == '__main__':
    vm_metadata = query_vm_metadata()

    # Retrieve a specific data key
    data_key = 'name'
    if data_key in vm_metadata:
        value = vm_metadata[data_key]
        print(f"{data_key}: {value}")
    else:
        print(f"Data key '{data_key}' not found in the Azure VM metadata.")

