fx_version 'adamant'

game 'gta5'

description 'Mafia Manager'

version '1.0.0'

client_scripts {
    'shared/config.lua',
    'client/main.lua'
}

server_scripts {
    'shared/config.lua',
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'server/classes/mafia.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/css/style.css',
    'html/js/app.js',
}