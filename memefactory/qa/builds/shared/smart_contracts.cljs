(ns memefactory.shared.smart-contracts) 

(def smart-contracts 
{:district-config
 {:name "DistrictConfig",
  :address "0x77814cadfb5c3b7d873f0b37e01ad4a71f3851c5"},
 :ds-guard
 {:name "DSGuard",
  :address "0xaec782e06af027710fbdb329163afd9d708e3d84"},
 :param-change-registry
 {:name "ParamChangeRegistry",
  :address "0xb639254e441036aef1eaaa35c200d246ae32354f"},
 :param-change-registry-db
 {:name "EternalDb",
  :address "0xc318eb1f620582606886ff9f8fdcfe16fd5a0868"},
 :meme-registry-db
 {:name "EternalDb",
  :address "0xecbedda1b343f93dc83c1394f8dd89e3fa07cfd5"},
 :param-change
 {:name "ParamChange",
  :address "0x0eb025fda6348d02ed0141dbc8e4a2f3453d751b"},
 :minime-token-factory
 {:name "MiniMeTokenFactory",
  :address "0x4b33f1fa2b20be587ceae4a54d5de0736bcef9d5"},
 :meme-auction-factory
 {:name "MemeAuctionFactory",
  :address "0x8cb025a31c00786447aac8fe3c06a0443de4a6ac"},
 :meme-auction
 {:name "MemeAuction",
  :address "0x95a987e436aac5dc67d2f4dfc1b5d63bb8b9162f"},
 :param-change-factory
 {:name "ParamChangeFactory",
  :address "0x4c9a81fc475203bc903ff1c119f658b7558fd2c6"},
 :param-change-registry-fwd
 {:name "MutableForwarder",
  :address "0x5b95a79855ec38585ea455f111c7649b331eac63"},
 :meme-factory
 {:name "MemeFactory",
  :address "0xe3c9660eccc58e2c69382cb6bf97ba9675663ece"},
 :meme-token
 {:name "MemeToken",
  :address "0x54a7991d27e313f6a55b206b5257ea545c786776"},
 :DANK
 {:name "DankToken",
  :address "0x5f541c6d08dd8f3f628bcaae587a0635ba5804a8"},
 :meme-registry
 {:name "Registry",
  :address "0x0b855b955209667939c89dfea6d4d14551f46c0e"},
 :meme
 {:name "Meme",
  :address "0xc0d445cbdae48ed1165614a99a1d084f403513fb"},
 :meme-registry-fwd
 {:name "MutableForwarder",
  :address "0xf239886c771c90f24f6cc7b851794aa613f3ba3f"},
 :meme-auction-factory-fwd
 {:name "MutableForwarder",
  :address "0xe77b82c6407cd6fce49540cacd3efc1bb890ce60"}})
