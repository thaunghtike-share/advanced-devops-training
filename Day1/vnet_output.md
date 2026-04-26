# 📖 Technical Reference: Terraform Networking Output Transformation

ဒီ Guide ကတော့ ငါတို့ Networking Module ရဲ့ outputs.tf မှာ ဘာကြောင့် Data တွေကို Loop ပတ်ပြီး Format ပြန်ချရသလဲဆိုတာကို Senior DevOps အမြင်နဲ့ ပြည့်စုံစွာ ရှင်းပြထားတာ ဖြစ်တယ်။

---

## ပြဿနာ- Raw Format (Loop မပတ်ခင်) ၏ အခက်အခဲ

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
အဲ့ output ကြီးကို အခြား vm, aks တို့လို Module တွေမှာ ပြန်ခေါ်သုံးချင်ရင် Data တွေက အရမ်းရှုပ်ထွေးနေမယ်။ Azure Resource တွေ (ဥပမာ VM ရဲ့ NIC, AKS ရဲ့ subnet ID ) ဟာ String ကိုပဲ လက်ခံတာဖြစ်ပြီး အပေါ်က Object ကြီးကို လက်မခံတဲ့အတွက် Type Mismatch Error တက်လိမ့်မယ်။

###  Argument Types ဆိုတာ ဘာလဲ?

​Argument ဆိုတာ resource တစ်ခု ဆောက်ရင် ထည့်ပေးရတဲ့ field တွေပါ။ Azure Resource တိုင်းမှာ သူ့ရဲ့ Argument တစ်ခုချင်းစီအတွက် လက်ခံတဲ့ Data Type အသေအချာ ရှိပါတယ်။

- Name: String ပဲ လက်ခံတယ်။ (ဥပမာ- "my-vm")
- Network Interface ID: String ပဲ လက်ခံတယ်။ (ဥပမာ- "/subscriptions/.../nic1")
- Tags: Map ပဲ လက်ခံတယ်။ (ဥပမာ- { "env" = "prod" })

### for_each ကြောင့်ဖြစ်လာတဲ့ Type Error ပြဿနာ

ငါတို့က VNET တွေ၊ Subnets တွေကို for_each သုံးပြီး ဆောက်လိုက်တဲ့အခါ Terraform ရဲ့ State ထဲမှာ အဲ့ဒီ Resource ကြီးက Map of Objects (အပေါ်မှာပြခဲ့တဲ့ Raw Format ကြီး) ဖြစ်သွားပါတယ်။ တကယ်လို့ ငါတို့က Raw Format အတိုင်းပဲ output ထုတ်ပေးလိုက်မယ်ဆိုရင်:

- VM Module က မျှော်လင့်တာ: String တစ်ခုတည်း (Subnet ID)။
- VNET Module က ပေးလိုက်တာ: Object အကြီးကြီး (Map)။
- ရလဒ်: "Incompatible variable type" ဆိုပြီး Error တက်လာပါလိမ့်မယ်။ Object ကို String ထဲ အတင်းထည့်လို့ မရလို့ပါ။

### ဖြေရှင်းချက်- k => v.id ဖြင့် Data Cleaning လုပ်ခြင်း

ငါတို့က outputs.tf မှာ အခုလို logic ကို သုံးပြီး Data ကို လိုချင်တဲ့ format ရအောင် ပြင်လိုက်တာ ဖြစ်တယ်။

- Key (k): Variable (var.vnets) ထဲမှာ မင်းပေးခဲ့တဲ့ နာမည်တွေဖြစ်တဲ့ mahar-vnet, vpn-vnet ဆိုတာတွေက Key အဖြစ် ပြန်ပါလာတာ။ ဒါကြောင့် နောက် Module ကနေ ခေါ်သုံးရင် ကိုယ်ပေးခဲ့တဲ့ နာမည်လေး သိရုံနဲ့တင် ရှာရတာ လွယ်သွားတယ်။

- Value (v.id): ဒါကတော့ Azure ဘက်ကနေ Resource ဆောက်ပြီးမှ ရလာတဲ့ Resource ID ဖြစ်တယ်။ ဒီ ID ကို Terraform Documentation ရဲ့ azurerm_virtual_network - Attribute Reference အောက်မှာ ကြည့်နိုင်တယ်။ v ဆိုတဲ့ object အပုံကြီးထဲကမှ ငါတို့က .id တစ်ခုတည်းကိုပဲ သီးသန့် "ဆွဲထုတ်" (Filter) လိုက်တာ။

### Folder တိုင်းမှာ Output ထည့်ရခြင်းရဲ့ ရည်ရွယ်ချက် (Data Contract)

ဘာကြောင့် Folder (Module) တိုင်းမှာ Output တွေ သီးသန့်ထည့်ပြီး k => v.id တွေ ရေးနေရသလဲဆိုရင်:

- Type Conversion (Type Casting): Map ကြီးထဲကနေ လိုချင်တဲ့ ID တစ်ခုတည်းကို ဆွဲထုတ်ပြီး String Map အဖြစ် ပြောင်းပေးလိုက်တာပါ။ ဒါမှ နောက် module က ခေါ်သုံးတဲ့အခါ Type တူသွားပြီး Error မတက်တော့တာ ဖြစ်ပါတယ်။

- Interface Standard: Module တစ်ခုဟာ သူ့ဆီမှာရှိတဲ့ resources တွေထဲက ဘယ်အချက်အလက်ကိုပဲ အပြင်ထုတ်ပေးမယ်ဆိုတာကို Output နဲ့ ကန့်သတ်ထားတာပါ။ ဒါမှ နောက် Module က လိုအပ်တာကိုပဲ တိုက်ရိုက်ယူသုံးနိုင်မှာ ဖြစ်ပါတယ်။

- Cross-Module Communication: Terraform မှာ Folder (Module) တစ်ခုနဲ့တစ်ခုက တိုက်ရိုက် စကားပြောလို့ မရပါဘူး။ Output ဆိုတဲ့ "တံခါးပေါက်" ရှိမှသာ တခြား Folder က လှမ်းယူလို့ ရတာဖြစ်ပါတယ်။

### ဥပမာဖြင့် ရှင်းလင်းချက်

မင်း VM ဆောက်ဖို့အတွက် Networking Folder ဆီကနေ Subnet ID လှမ်းတောင်းတယ် ဆိုပါစို့။

- Networking Folder (Supplier): "ငါ့ဆီမှာ Subnet တွေ အများကြီးရှိတယ်။ မင်းလိုချင်တဲ့ နာမည်ပြော၊ ငါကတော့ String ID ပဲ ထုတ်ပေးမယ်" လို့ format ချထားပေးရတယ်။

- VM Folder (Consumer): "ငါက String ID ပဲ သိတယ်။ မင်းပေးတဲ့ String ကို ယူပြီး VM ရဲ့ subnet_id field ထဲကို တန်းထည့်လိုက်မယ်။"

### ပြန်ခေါ်သုံးတဲ့အခါ ဘယ်လိုလွယ်ကူသွားသလဲ?

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