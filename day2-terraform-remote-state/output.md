# 📖 Technical Reference: Terraform Networking Output Transformation

ဒီ Guide သည် for_each အသုံးပြုထားသော Networking Resources များကို အခြား Module (VM, AKS) များမှ ခေါ်ယူအသုံးပြုရာတွင် Type Mismatch Error မတက်စေရန်နှင့် Data Contract ရှင်းလင်းစေရန် ရည်ရွယ်ပါသည်။

---

## ပြဿနာ- Raw Format

01_networking ကိုအခြား 03_az_vm တို့ကနေပြန်ခေါ်ဖို့အတွက် နည်းလမ်း၂ခုကိုရှင်းပြထားတယ်။ အရင်ပြောပြမှာက simple way ဖြစ်တယ်။ ဒါမယ့် professional နည်းလမ်း တော့မဟုတ်ဖူး။

```hcl
output "vnets" {
  value = azurerm_virtual_network.vnet
}

output "subnets" {
  value = azurerm_subnet.subnet
}
```
Terraform မှာ `for_each` ကိုသုံးပြီး Resource တွေအများကြီး ဆောက်တဲ့အခါ output ထုတ်ရင် သတိထားရမယ့် အချက်တွေရှိတယ်။ 

တကယ်လို့ output မှာ `for` loop မသုံးဘဲ `value = azurerm_virtual_network.vnet` `value = azurerm_subent.subnet`နဲ့ ဆိုပြီး ဒီအတိုင်း ထုတ်လိုက်ရင် Azure ကပေးတဲ့ Data တွေအကုန် အောက်ကအတိုင်း  **Raw Object Format** ကြီးနဲ့ ပေါ်နေလိမ့်မယ်။ 

```hcl
subnets = {
  "mahar-vnet.default" = {
    "address_prefixes" = tolist([
      "10.224.0.0/16",
    ])
    "default_outbound_access_enabled" = true
    "delegation" = tolist([])
    "id" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/mahar-vnet/subnets/default"
    "name" = "default"
    "resource_group_name" = "mahar"
    "virtual_network_name" = "mahar-vnet"
  }
  "vpn-vnet.default" = {
    "address_prefixes" = tolist([
      "10.20.1.0/24",
    ])
    "id" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/vpn-vnet/subnets/default"
    "name" = "default"
    "resource_group_name" = "mahar"
    "virtual_network_name" = "vpn-vnet"
  }
}
vnets = {
  "mahar-vnet" = {
    "address_space" = toset([
      "10.224.0.0/12",
    ])
    "guid" = "239aa0fb-240d-4666-9c6c-20db4023d96b"
    "id" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/mahar-vnet"
    "location" = "southeastasia"
    "name" = "mahar-vnet"
    "resource_group_name" = "mahar"
    "subnet" = toset([
      {
        "address_prefixes" = tolist([
          "10.224.0.0/16",
        ])
        "id" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/mahar-vnet/subnets/default"
        "name" = "default"
      },
    ])
    "tags" = tomap({
      "ManagedBy" = "Terraform"
      "Project" = "MBR"
    })
  }
  "vpn-vnet" = {
    "address_space" = toset([
      "10.20.0.0/16",
    ])
    "guid" = "d16af0f0-eb18-4f02-b665-cba2aed3f801"
    "id" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/vpn-vnet"
    "ip_address_pool" = tolist([])
    "location" = "southeastasia"
    "name" = "vpn-vnet"
    "resource_group_name" = "mahar"
    "subnet" = toset([
      {
        "address_prefixes" = tolist([
          "10.20.1.0/24",
        ])
        "default_outbound_access_enabled" = true
        "id" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/vpn-vnet/subnets/default"
        "name" = "default"
      },
    ])
    "tags" = tomap({
      "ManagedBy" = "Terraform"
      "Project" = "MBR"
    })
  }
}
```

remote state data source ကိုပြန်သုံးမယ်ဆိုရင် output ထဲမှာပဲသွားဖတ်နိုင်ပါတယ်။ အပေါ်က subnets မှာဆိုရင် subnet ၂ခု vnet ၂ခုကို for_each နဲ့ create လုပ်ခဲ့တာမလို့ key = value ပုံစံနဲ့ထွက်လာပါမယ်။ subnets output ကိုကြည့်မယ်ဆိုရင် mahar-vnet.default နဲ့ vpn-vnet.default ဟာ key တွေဖြစ်ပါတယ်။ vnets output ကိုကြည့်ရင် mahar-vnet နဲ့ vpn-vnet ဟာ key တွေဖြစ်ကြပါတယ်။ 

## ❌ မှားယွင်းသော ခေါ်ယူပုံ 

VM Module က subnet_id နေရာမှာ String ပဲ လက်ခံပါတယ်။ မင်းက အပေါ်က Map ကြီးကို တန်းထည့်လိုက်ရင် Error တက်ပါမယ်။

```hcl
# 02_az_vm
subnet_id = data.terraform_remote_state.networking.outputs.subnets # Error! (It's a Map, not a String)
```
### ဖြေရှင်းနည်း (Method A) - Raw Format ကို Index လုပ်၍ ခေါ်ခြင်း

အကယ်၍ outputs.tf မှာ Loop မပတ်ထားဘူးဆိုရင်၊ ခေါ်သုံးတဲ့နေရာမှာ လိုချင်တဲ့ Key နဲ့ Attribute (.id) ကို တိတိကျကျ ညွှန်းပေးရပါမယ်။ 

```hcl
resource "azurerm_network_interface" "vm_nic" {
  ip_configuration {
    name = "internal"
    # ၁။ Map ထဲက Key ကို အရင်ခေါ် ["mahar-vnet.default"] -> Object ရမယ်
    # ၂။ ၎င်း Object ထဲကမှ .id ကို ထပ်ဆင့်ခေါ် -> String ရမယ်
    subnet_id = data.terraform_remote_state.networking.outputs.subnets["mahar-vnet.default"].id
  }
}
```
> မှတ်ချက်: ဒီနည်းလမ်းက အလုပ်လုပ်ပေမဲ့ Key နာမည်မှားတာ ဒါမှမဟုတ် .id ထည့်ဖို့ မေ့သွားတာနဲ့ Type Error တက်ဖို့ အခွင့်အလမ်း များပါတယ်။

### vnets Raw Format ကို နားလည်ခြင်း

sample output အရ vnets သည်လည်း Map of Objects ဖြစ်ပါတယ်။ Key တစ်ခုချင်းစီ (ဥပမာ- mahar-vnet) ရဲ့ အောက်မှာ Azure Resource တစ်ခုလုံးရဲ့ properties တွေ အကုန်ပါလာပါတယ်။

Sample Raw Data (from your output)

```hcl
vnets = {
  "mahar-vnet" = {
    "id"            = "/subscriptions/.../virtualNetworks/mahar-vnet"
    "location"      = "southeastasia"
    "address_space" = ["10.224.0.0/12"]
    "tags"          = { "Project" = "MBR" }
    "guid"          = "239aa0fb-240d-4666-9c6c-20db4023d96b"
    # ... တခြား properties များစွာ ...
  }
}
```

အကယ်၍ outputs.tf မှာ loop မပတ်ဘဲ value = azurerm_virtual_network.vnet လို့ပဲ ထုတ်ထားမယ်ဆိုရင်၊ 02_az_vm ဒါမှမဟုတ် တခြား module တွေကနေ အောက်ပါအတိုင်း ခေါ်သုံးရပါမယ်။

```hcl
resource "azurerm_xxx "this" {
    vnet_id = data.terraform_remote_state.networking.outputs.vnets["mahar-vnet"].id
  }
}
```

### ဖြေရှင်းချက်- k => v.id ဖြင့် Data Cleaning လုပ်ခြင်း

Terraform မှာ Resource တစ်ခုကို for_each နဲ့ ဆောက်လိုက်တဲ့အခါ v (Value) ဆိုတဲ့ Object အထဲမှာ Azure က ပေးလိုက်တဲ့ Attribute တွေ (ဥပမာ- guid, dns_settings, bgp_community) အများကြီး ပါနေပါတယ်။

ကျွန်တော်တို့က Loop ပတ်ပြီး v.id လို့ ရေးလိုက်တဲ့အခါ-

- Filter လုပ်ခြင်း: Object တစ်ခုလုံးမှာ ပါသမျှ အမှိုက်တွေကို ဖယ်ပြီး .id (Resource ID) တစ်ခုတည်းကိုပဲ ဆွဲထုတ်လိုက်တာပါ။
- Weight လျှော့ချခြင်း: မလိုအပ်တဲ့ Data တွေ မပါတော့တဲ့အတွက် Terraform State file ရဲ့ Size ကို ပေါ့ပါးသွားစေပါတယ်။
- Type Matching: Map of Objects ကြီးကနေ Map of Strings ဖြစ်သွားအောင် ကျွန်တော်တို့က Type ပြောင်းလဲ (Transform) လိုက်တာ ဖြစ်ပါတယ်။

```hcl
output "vnet_ids" {
  value = { for k, v in azurerm_virtual_network.vnet : k => v.id }
}

output "subnet_ids" {
  value = { for k, v in azurerm_subnet.subnet : k => v.id }
}
```

loop ပတ်ပြီး  k => v.id ဆိုတာ key = value.id နဲ့တူသွားမယ်လို့သတ်မှတ်လိုက်တာ။ subnet ရဲ့ key တွေဖြစ်တဲ့ mahar-vnet.default နဲ့ vpn-vnet.default ဟာ id နဲ့တူသွားတယ်

- Key (k): Variable (var.vnets) ထဲမှာ မင်းပေးခဲ့တဲ့ နာမည်တွေဖြစ်တဲ့ mahar-vnet, vpn-vnet ဆိုတာတွေက Key အဖြစ် ပြန်ပါလာတာ။ ဒါကြောင့် နောက် Module ကနေ ခေါ်သုံးရင် ကိုယ်ပေးခဲ့တဲ့ နာမည်လေး သိရုံနဲ့တင် ရှာရတာ လွယ်သွားတယ်။

- Value (v.id): ဒါကတော့ Azure ဘက်ကနေ Resource ဆောက်ပြီးမှ ရလာတဲ့ Resource ID ဖြစ်တယ်။ ဒီ ID ကို Terraform Documentation ရဲ့ azurerm_virtual_network - Attribute Reference အောက်မှာ ကြည့်နိုင်တယ်။ v ဆိုတဲ့ object အပုံကြီးထဲကမှ ငါတို့က .id တစ်ခုတည်းကိုပဲ သီးသန့် "ဆွဲထုတ်" (Filter) လိုက်တာ။

ကျွန်တော်တို့ Clean လုပ်ပြီးတဲ့အခါ ရလာတဲ့ Output က အရမ်းကို သန့်ရှင်းသွားပါပြီ။။ sample output ကိုကြည့်လိုက်ရအောင် 

```hcl
subnet_ids = {
  "mahar-vnet.default" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/mahar-vnet/subnets/default"
  "vpn-vnet.default" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/vpn-vnet/subnets/default"
}
vnet_ids = {
  "mahar-vnet" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/mahar-vnet"
  "vpn-vnet" = "/subscriptions/6f48750e-5037-4321-9d8b-a9e58c87accf/resourceGroups/mahar/providers/Microsoft.Network/virtualNetworks/vpn-vnet"
}
```

### အခြား Module (02_az_vm) ကနေ ပြန်ခေါ်ယူပုံ

ဒီလို Format ချထားပေးတဲ့အတွက် 02_az_vm မှာ ပြန်ခေါ်သုံးရတာဟာ ပိုပြီး ရိုးရှင်းသွားပါတယ်။

VNet ID ကို ခေါ်သုံးခြင်း

```hcl
# 02_az_vm/main.tf
vnet_id = data.terraform_remote_state.networking.outputs.vnet_ids["mahar-vnet"]
```

> ဒီနေရာမှာ .id ဆိုပြီး ထပ်ဆင့်ခေါ်စရာ မလိုတော့ပါဘူး။ ဘာလို့လဲဆိုတော့ vnet_ids["mahar-vnet"] ကို ခေါ်လိုက်တာနဲ့ String ID တန်းထွက်လာမှာ ဖြစ်လို့ပါ။ အဲ့လို .id ဆိုပြီး မခေါ်ချင်လို့ ကိုယ်လိုချင်တဲ့ data တွေကိုရဖို့ output မှာ loop ပတ်ခဲ့တာဖြစ်ပါတယ်။

### Subnet ID ကို ခေါ်သုံးခြင်း

```hcl
# VM ရဲ့ Network Interface ဆောက်တဲ့နေရာမှာ သုံးပုံ
resource "azurerm_network_interface" "vm_nic" {
  # ...
  ip_configuration {
    name      = "internal"
    # Subnet name (Key) ကို သိရုံနဲ့ ID ကို တန်းရပါတယ်
    subnet_id = data.terraform_remote_state.networking.outputs.subnet_ids["mahar-vnet.default"]
  }
}
```