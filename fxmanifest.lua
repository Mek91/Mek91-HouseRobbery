fx_version 'cerulean'

game 'gta5'

author 'mek91'

description 'Mek91-HR - (House Robbery)'

version '1.0'

shared_script {
    'Languages/*.lua',
    'Configs/*.lua',
    'Configs/AdjustableFunctions/*.lua',
}

server_script {
    'Files/Servers/*.lua'
}

client_scripts {
    'Files/Clients/*.lua'
}

files {
    'Ui/index.html',
    'Ui/Css/Mek91HR.css',
    'Ui/Js/Mek91HR.js'
}

ui_page {
    'Ui/index.html'
}

dependencies {
	'qb-core'
}

lua54 'yes'