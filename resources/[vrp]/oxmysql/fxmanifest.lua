fx_version 'cerulean'
game 'common'

dependencies {
	--'/server:5104',
}

server_scripts {
	'dist/server/build.js',
}

provide 'mysql-async'