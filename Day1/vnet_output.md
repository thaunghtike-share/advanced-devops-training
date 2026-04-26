# 📖 Technical Reference: Terraform Data Transformation

This document details how we convert raw Azure Resource Objects into clean, searchable Maps within our `outputs.tf`.

---

## 1. The Raw Data Source (`v`)

When Terraform creates resources using `for_each`, it stores them as a Map of Objects. Each object `v` contains the full set of **attributes** returned by the Azure API. 

**Raw State Representation of `v` before filtering:**

```hcl
{
  "mahar-vnet" = {                             # This is 'k' (The Key)
    "address_space"           = ["10.224.0.0/12"]
    "dns_servers"             = []
    "guid"                    = "239aa0fb-240d-4666-9c6c-20db4023d96b"
    "id"                      = "/subscriptions/.../virtualNetworks/mahar-vnet" # <-- v.id
    "location"                = "southeastasia"
    "name"                    = "mahar-vnet"
    "resource_group_name"     = "mahar"
    "tags"                    = { "Project" = "MBR" }
    "bgp_community"           = ""
    "flow_timeout_in_minutes" = 0
  },
  "vpn-vnet" = {                               # This is the next 'k'
    "address_space"           = ["10.20.0.0/16"]
    "id"                      = "/subscriptions/.../virtualNetworks/vpn-vnet"   # <-- v.id
    "location"                = "southeastasia"
    "name"                    = "vpn-vnet"
    # ... additional attributes ...
  }
}
```
## 2. The Transformation Logic

We use a for loop to "pluck" specific attributes (like id) out of the giant raw block.

```hcl
output "vnet_ids" {
  value = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}
```

### How the Variables Work:

- k (Key): The human-readable name from your .tfvars (e.g., "vpn-vnet or mahar-vnet").
- v (Value): The entire raw object block (Attributes) shown in Section 1.
- v.id: A specific pointer to the id string inside that raw block.

## 3. The Final Map (The "Clean" Output)

The result of the k => v.id mapping is a high-performance Map of Strings. This is what is stored in the outputs section of the Remote State.

```hcl
vnet_ids = {
  "mahar-vnet" = "/subscriptions/6f48.../resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/mahar-vnet"
  "vpn-vnet"   = "/subscriptions/6f48.../resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/vpn-vnet"
}
```

## 4. Why This Architecture is Used

1. Attribute Filtering: Azure returns ~50 attributes per VNET. We only export the id to keep the state clean and efficient.

2. Type Safety: Downstream resources (like VM NICs or Peering) expect a string. If we passed the whole object v, the deployment would fail due to a type mismatch.

3. Searchability: By using a Map, other developers can find a specific ID instantly by its name instead of iterating through a long, unlabelled list.

### Summary for Junior DevOps

Variables define our intent → Azure Attributes provide the raw data (v) → Outputs filter that data into a clean Map (k => v.id).