fx_version 'cerulean'
games {'gta5'}
description 'Add-on weapon generated using vWeaponsToolkit'

files{
	'**/weaponcomponents.meta',
	'**/weaponarchetypes.meta',
	'**/weaponanimations.meta',
	'**/pedpersonality.meta',
	'**/weapons.meta',
	'**/weaponSPR.meta',
}


data_file 'WEAPONCOMPONENTSINFO_FILE' '**/weaponcomponents.meta'
data_file 'WEAPON_METADATA_FILE' '**/weaponarchetypes.meta'
data_file 'WEAPON_ANIMATIONS_FILE' '**/weaponanimations.meta'
data_file 'PED_PERSONALITY_FILE' '**/pedpersonality.meta'
data_file 'WEAPONINFO_FILE'        '**/weaponSPR.meta'
data_file 'WEAPONINFO_FILE_PATCH'  '**/weapons.meta'

client_script 'cl_weaponNames.lua'
