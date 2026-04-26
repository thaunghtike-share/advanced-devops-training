## VNET Output ပုံစံကို Loop ပတ်ပြီး Format ချရခြင်း အကြောင်းအရင်း

Terraform မှာ for_each ကိုသုံးပြီး Resource တွေအများကြီး ဆောက်တဲ့အခါ output ထုတ်ရင် သတိထားရမယ့် အချက်တွေရှိတယ်။

### ၁။ Raw Format နဲ့ ပေါ်နေမှာကို ရှင်းထုတ်ခြင်း

တကယ်လို့ ```for loop``` မသုံးဘဲ ```value = azurerm_virtual_network.vnet``` ဆိုပြီး ဒီအတိုင်း ထုတ်လိုက်ရင် Azure ကပေးတဲ့ Data တွေအကုန် (ဥပမာ - address_space, location, guid, dns_settings စတာတွေအကုန်) Raw Object Format ကြီးနဲ့ ပေါ်နေလိမ့်မယ်။ 

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

အဲ့ဒီအခါ တစ်ခြား Module မှာ ပြန်ခေါ်သုံးချင်ရင် Data တွေက ရှုပ်ထွေးနေပြီး လိုချင်တဲ့ ID တစ်ခုတည်းကို ဆွဲထုတ်ရတာ ခက်ခဲစေတယ်။

### ၂။ Key နဲ့ Value ဘယ်ကရသလဲ?

ဒီနေရာမှာ k => v.id ဆိုတဲ့ logic က အရေးကြီးတယ်:

- Key (k): Variable (var.vnets) ထဲမှာ မင်းပေးခဲ့တဲ့ နာမည်တွေဖြစ်တဲ့ mahar-vnet, vpn-vnet ဆိုတာတွေက Key အဖြစ် ပြန်ပါလာတာ။ ဒါကြောင့် နောက် Module ကနေ ခေါ်သုံးရင် ကိုယ်ပေးခဲ့တဲ့ နာမည်နဲ့တင် ရှာရတာ လွယ်သွားတယ်။

- Value (v.id): ဒါကတော့ Azure ဘက်ကနေ Resource ဆောက်ပြီးမှ ရလာတဲ့ Resource ID တွေဖြစ်တယ်။ ဒီ ID တွေကို Terraform Documentation ရဲ့ azurerm_virtual_network - Attribute Reference အောက်မှာ ကြည့်နိုင်တယ်။ v ထဲမှာ attribute တွေအများကြီးရှိတဲ့အထဲကမှ ငါတို့က .id တစ်ခုတည်းကိုပဲ သီးသန့် Filter လုပ်ပြီး ထုတ်လိုက်တာ။

### ၃။ ပြန်ခေါ်သုံးတဲ့အခါ ဘယ်လိုလွယ်ကူသွားသလဲ?

ဒီလို format ချထားပေးတဲ့အတွက် နောက် Module တစ်ခု (ဥပမာ - NAT Gateway သို့မဟုတ် Virtual Machine) ကနေ ဒီ VNET ID ကို လိုချင်တဲ့အခါ ရှုပ်ရှုပ်ရှက်ရှက်တွေ လိုက်ရှာနေစရာ မလိုတော့ဘူး။

ဥပမာအားဖြင့် -

ဒီလို vnet_ids output ဟာ Map ပုံစံမျိုး ထွက်လာတဲ့အတွက်:

```hcl
vnet_ids = {
  "mahar-vnet" = "/subscriptions/.../vnet-mahar-id"
  "vpn-vnet"   = "/subscriptions/.../vnet-vpn-id"
}
```

တခြားနေရာမှာ ပြန်သုံးရင် ဒီလိုပဲ တိုက်ရိုက် ခေါ်လို့ရသွားတယ် ```data.terraform_remote_state.network.outputs.vnet_ids["mahar-vnet"]```

အနှစ်ချုပ်ပြောရရင် ဒီလို ရေးပေးခြင်းအားဖြင့် Output Data ကို Weight ပေါ့သွားစေတယ် (Clean ဖြစ်စေတယ်)၊ နောက်ပြီး တစ်ခြား Module တွေကနေ ပြန်ခေါ်သုံးတဲ့အခါမှာလည်း ကိုယ်ပေးခဲ့တဲ့ Key နာမည်လေး သိရုံနဲ့တင် ID ကို တိုက်ရိုက် ဆွဲယူနိုင်သွားစေတာ ဖြစ်ပါတယ်။