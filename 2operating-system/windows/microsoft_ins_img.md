{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "location": {
            "type": "string"
        },
        "networkInterfaceName": {
            "type": "string"
        },
        "networkSecurityGroupName": {
            "type": "string"
        },
        "networkSecurityGroupRules": {
            "type": "array"
        },
        "subnetName": {
            "type": "string"
        },
        "virtualNetworkName": {
            "type": "string"
        },
        "addressPrefixes": {
            "type": "array"
        },
        "subnets": {
            "type": "array"
        },
        "publicIpAddressName": {
            "type": "string"
        },
        "publicIpAddressType": {
            "type": "string"
        },
        "publicIpAddressSku": {
            "type": "string"
        },
        "virtualMachineName": {
            "type": "string"
        },
        "virtualMachineRG": {
            "type": "string"
        },
        "osDiskType": {
            "type": "string"
        },
        "dataDisks": {
            "type": "array"
        },
        "dataDiskResources": {
            "type": "array"
        },
        "virtualMachineSize": {
            "type": "string"
        },
        "adminUsername": {
            "type": "string"
        },
        "adminPassword": {
            "type": "secureString"
        },
        "diagnosticsStorageAccountName": {
            "type": "string"
        },
        "diagnosticsStorageAccountId": {
            "type": "string"
        },
        "diagnosticsStorageAccountType": {
            "type": "string"
        },
        "diagnosticsStorageAccountKind": {
            "type": "string"
        }
    },
    "variables": {
        "nsgId": "[resourceId(resourceGroup().name, 'Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroupName'))]",
        "vnetId": "[resourceId(resourceGroup().name,'Microsoft.Network/virtualNetworks', parameters('virtualNetworkName'))]",
        "subnetRef": "[concat(variables('vnetId'), '/subnets/', parameters('subnetName'))]"
    },
    "resources": [
        {
            "name": "[parameters('networkInterfaceName')]",
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "2019-07-01",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.Network/networkSecurityGroups/', parameters('networkSecurityGroupName'))]",
                "[concat('Microsoft.Network/virtualNetworks/', parameters('virtualNetworkName'))]",
                "[concat('Microsoft.Network/publicIpAddresses/', parameters('publicIpAddressName'))]"
            ],
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "subnet": {
                                "id": "[variables('subnetRef')]"
                            },
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIpAddress": {
                                "id": "[resourceId(resourceGroup().name, 'Microsoft.Network/publicIpAddresses', parameters('publicIpAddressName'))]"
                            }
                        }
                    }
                ],
                "networkSecurityGroup": {
                    "id": "[variables('nsgId')]"
                }
            }
        },
        {
            "name": "[parameters('networkSecurityGroupName')]",
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2019-02-01",
            "location": "[parameters('location')]",
            "properties": {
                "securityRules": "[parameters('networkSecurityGroupRules')]"
            }
        },
        {
            "name": "[parameters('virtualNetworkName')]",
            "type": "Microsoft.Network/virtualNetworks",
            "apiVersion": "2019-04-01",
            "location": "[parameters('location')]",
            "properties": {
                "addressSpace": {
                    "addressPrefixes": "[parameters('addressPrefixes')]"
                },
                "subnets": "[parameters('subnets')]"
            }
        },
        {
            "name": "[parameters('publicIpAddressName')]",
            "type": "Microsoft.Network/publicIpAddresses",
            "apiVersion": "2019-02-01",
            "location": "[parameters('location')]",
            "properties": {
                "publicIpAllocationMethod": "[parameters('publicIpAddressType')]"
            },
            "sku": {
                "name": "[parameters('publicIpAddressSku')]"
            }
        },
        {
            "name": "[parameters('dataDiskResources')[copyIndex()].name]",
            "type": "Microsoft.Compute/disks",
            "apiVersion": "2019-07-01",
            "location": "[parameters('location')]",
            "properties": "[parameters('dataDiskResources')[copyIndex()].properties]",
            "sku": {
                "name": "[parameters('dataDiskResources')[copyIndex()].sku]"
            },
            "copy": {
                "name": "managedDiskResources",
                "count": "[length(parameters('dataDiskResources'))]"
            }
        },
        {
            "name": "[parameters('virtualMachineName')]",
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2019-07-01",
            "location": "[parameters('location')]",
            "dependsOn": [
                "managedDiskResources",
                "[concat('Microsoft.Network/networkInterfaces/', parameters('networkInterfaceName'))]",
                "[concat('Microsoft.Storage/storageAccounts/', parameters('diagnosticsStorageAccountName'))]"
            ],
            "properties": {
                "hardwareProfile": {
                    "vmSize": "[parameters('virtualMachineSize')]"
                },
                "storageProfile": {
                    "osDisk": {
                        "createOption": "fromImage",
                        "managedDisk": {
                            "storageAccountType": "[parameters('osDiskType')]"
                        }
                    },
                    "imageReference": {
                        "publisher": "MicrosoftWindowsServer",
                        "offer": "WindowsServer",
                        "sku": "2016-Datacenter",
                        "version": "latest"
                    },
                    "copy": [
                        {
                            "name": "dataDisks",
                            "count": "[length(parameters('dataDisks'))]",
                            "input": {
                                "lun": "[parameters('dataDisks')[copyIndex('dataDisks')].lun]",
                                "createOption": "[parameters('dataDisks')[copyIndex('dataDisks')].createOption]",
                                "caching": "[parameters('dataDisks')[copyIndex('dataDisks')].caching]",
                                "writeAcceleratorEnabled": "[parameters('dataDisks')[copyIndex('dataDisks')].writeAcceleratorEnabled]",
                                "diskSizeGB": "[parameters('dataDisks')[copyIndex('dataDisks')].diskSizeGB]",
                                "managedDisk": {
                                    "id": "[coalesce(parameters('dataDisks')[copyIndex('dataDisks')].id, if(equals(parameters('dataDisks')[copyIndex('dataDisks')].name, json('null')), json('null'), resourceId('Microsoft.Compute/disks', parameters('dataDisks')[copyIndex('dataDisks')].name)))]",
                                    "storageAccountType": "[parameters('dataDisks')[copyIndex('dataDisks')].storageAccountType]"
                                }
                            }
                        }
                    ]
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaceName'))]"
                        }
                    ]
                },
                "osProfile": {
                    "computerName": "[parameters('virtualMachineName')]",
                    "adminUsername": "[parameters('adminUsername')]",
                    "adminPassword": "[parameters('adminPassword')]",
                    "windowsConfiguration": {
                        "enableAutomaticUpdates": true,
                        "provisionVmAgent": true
                    }
                },
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": true,
                        "storageUri": "[concat('https://', parameters('diagnosticsStorageAccountName'), '.blob.core.windows.net/')]"
                    }
                }
            }
        },
        {
            "name": "[parameters('diagnosticsStorageAccountName')]",
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2019-06-01",
            "location": "[parameters('location')]",
            "properties": {},
            "kind": "[parameters('diagnosticsStorageAccountKind')]",
            "sku": {
                "name": "[parameters('diagnosticsStorageAccountType')]"
            }
        }
    ],
    "outputs": {
        "adminUsername": {
            "type": "string",
            "value": "[parameters('adminUsername')]"
        }
    }
}
