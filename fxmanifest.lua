fx_version 'cerulean'
lua54 'yes'
game 'gta5'

author 'Marolli'
description 'Darmowy napad na sklepik by marolli_'

client_scripts {
    'config.lua',
    'client/client.lua'
}

server_scripts {
    'config.lua', 
    'server/server.lua',
    '@mysql-async/lib/MySQL.lua',
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua'
}
