fx_version("cerulean")
game("gta5")

author("Ludaro")
description("Ludaro Smartwatch hud")
version("1.0.0")

client_scripts({
	"client/*.lua",
})

server_scripts({
		"server/*.lua",
	"@oxmysql/lib/MySQL.lua",
})

shared_scripts({
	"config/*.lua"
})

ui_page({
	"html/dist/index.html",
})

files({
	"html/dist/index.html",
	"html/dist/assets/*.*",
})

lua54("yes")
