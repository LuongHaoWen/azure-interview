output "SPN_username"{
  value = azuread_service_principal.interview-spn.application_id
  description = "interview SPN details"
}

output "SPN_tenant_id"{
  value =azuread_service_principal.interview-spn.application_tenant_id
}

output "spn_password"{
  value = azuread_service_principal_password.SPN_password.value
  sensitive = true

}
output "interview-rg-name"{
 value = azurerm_resource_group.interview-rg.name
 description = "the name of your resourcd group"
}


output "interview-subnet-name"{
value = azurerm_subnet.interview-subnet.name
description = "the name of your subnet"
}

output "interview-interface"{
  value = azurerm_network_interface.interview-ni.name
  description = "the details of network interface"
}

output "interview-vnet"{
  value = azurerm_virtual_network.interview-vnet.name
}