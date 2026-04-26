# 📖 Technical Reference: Terraform Networking Output Transformation

ဒီ Guide ကတော့ ငါတို့ Networking Module ရဲ့ outputs.tf မှာ ဘာကြောင့် Data တွေကို Loop ပတ်ပြီး Format ပြန်ချရသလဲဆိုတာကို Senior DevOps အမြင်နဲ့ ပြည့်စုံစွာ ရှင်းပြထားတာ ဖြစ်တယ်။

---

## ၁။ ပြဿနာ- Raw Format (Loop မပတ်ခင်) ၏ အခက်အခဲ

Terraform မှာ `for_each` ကိုသုံးပြီး Resource တွေအများကြီး ဆောက်တဲ့အခါ output ထုတ်ရင် သတိထားရမယ့် အချက်တွေရှိတယ်။ တကယ်လို့ `for` loop မသုံးဘဲ `value = azurerm_virtual_network.vnet` ဆိုပြီး ဒီအတိုင်း ထုတ်လိုက်ရင် Azure ကပေးတဲ့ Data တွေအကုန် အောက်ကအတိုင်း (ဥပမာ - address_space, guid, dns_settings စတာတွေအကုန်) **Raw Object Format** ကြီးနဲ့ ပေါ်နေလိမ့်မယ်။

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

### ဘာကြောင့် အသုံးမဝင်တာလဲ:

- တစ်ခြား Module မှာ ပြန်ခေါ်သုံးချင်ရင် Data တွေက အရမ်းရှုပ်ထွေးနေမယ်။
- Azure Resource တွေ (ဥပမာ VM NIC) ဟာ String (ID) ကိုပဲ လက်ခံတာဖြစ်ပြီး အပေါ်က Object ကြီးကို လက်မခံတဲ့အတွက် Type Mismatch Error တက်လိမ့်မယ်။

### ၂။ ဖြေရှင်းချက်- k => v.id ဖြင့် Data Cleaning လုပ်ခြင်း

ငါတို့က outputs.tf မှာ အခုလို logic ကို သုံးပြီး Data ကို လိုချင်တဲ့ format ရအောင် ပြင်လိုက်တာ ဖြစ်တယ်။

- Key (k): Variable (var.vnets) ထဲမှာ မင်းပေးခဲ့တဲ့ နာမည်တွေဖြစ်တဲ့ mahar-vnet, vpn-vnet ဆိုတာတွေက Key အဖြစ် ပြန်ပါလာတာ။ ဒါကြောင့် နောက် Module ကနေ ခေါ်သုံးရင် ကိုယ်ပေးခဲ့တဲ့ နာမည်လေး သိရုံနဲ့တင် ရှာရတာ လွယ်သွားတယ်။

- Value (v.id): ဒါကတော့ Azure ဘက်ကနေ Resource ဆောက်ပြီးမှ ရလာတဲ့ Resource ID ဖြစ်တယ်။ ဒီ ID ကို Terraform Documentation ရဲ့ azurerm_virtual_network - Attribute Reference အောက်မှာ ကြည့်နိုင်တယ်။ v ဆိုတဲ့ object အပုံကြီးထဲကမှ ငါတို့က .id တစ်ခုတည်းကိုပဲ သီးသန့် "ဆွဲထုတ်" (Filter) လိုက်တာ။

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

vm တို့ nat gateway တို့ဆောက်တဲ့အခါ subnet id , vnet id တွေဟာ string ကိုပဲ လက်ခံတာမလို့ output နဲ့ type တူပြီး ဒီလို တိုက်ရိုက် ခေါ်လို့ရသွားတယ် ```data.terraform_remote_state.network.outputs.vnet_ids["mahar-vnet"]```

အနှစ်ချုပ်ပြောရရင် ဒီလို ရေးပေးခြင်းအားဖြင့် Output Data ကို Weight ပေါ့သွားစေတယ် (Clean ဖြစ်စေတယ်)၊ နောက်ပြီး တစ်ခြား Module တွေကနေ ပြန်ခေါ်သုံးတဲ့အခါမှာလည်း ကိုယ်ပေးခဲ့တဲ့ Key နာမည်လေး သိရုံနဲ့တင် ID ကို တိုက်ရိုက် ဆွဲယူနိုင်သွားစေတာ ဖြစ်ပါတယ်။