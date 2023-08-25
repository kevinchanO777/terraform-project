# az vm list --show-details --query "[*].{Name:name, ResourceGroup:resourceGroup, PowerState:powerState}" --output table
# List the states of each VM in Azure

#!/bin/sh

get_vm_status () {
	az vm list --show-details --query "[*].{Name:name, ResourceGroup:resourceGroup, PowerState:powerState}" --output table
}

get_vm_status

