server_script "K1.lua"
client_script "K1.lua"
description 'Mission Row Police Academy'
name 'ult-mrpd-training-leakinghub'
author '[Ultrunz] - https://discord.gg/KcDQHcD'

files {
    "interiorproxies.meta"
}

data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_02.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_03.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_04.ytyp'
data_file 'DLC_ITYP_REQUEST' 'vw_prop_vw_casino_art_05.ytyp'

client_scripts{ 
  "client.lua"
}

this_is_a_map 'yes'

fx_version 'adamant'
games {'gta5'}