import json
import subprocess

def query_vm_metadata():
    cmd = 'az vm show -d --ids $(az vm list --query "[].id" -o tsv)'
    output = subprocess.check_output(cmd, shell=True).decode('utf-8')
    vm_metadata = json.loads(output)
    return vm_metadata

if __name__ == '__main__':
    vm_metadata = query_vm_metadata()
    print(json.dumps(vm_metadata, indent=4))
