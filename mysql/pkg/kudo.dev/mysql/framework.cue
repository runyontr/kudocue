package mysql 

import "kudo.dev/core"

_kudo: core

//Update the default deployment to have a particular image/port
_kudo deployment <Name> spec template spec containers: [{
		image: "mysql:5.7"
			ports: [{
				containerPort: 3306
				export: true
			}]
	}]

//Update default Jobs
_kudo job <Name>: {
	image: "mysql:5.7"
	command: "create table"
	env: framework._password
}

_kudo job init: {}
_kudo job backup: {}
_kudo job restore: {}
_kudo deployment server: {}

//Instance of a mysql framework
framework: _kudo.framework._base & {
	_name: string
	_password: *"default" | string
	objects: {
		deployment server: {
			name: _name
			env: {
				name: "MYSQL_ROOT_PASSWORD"
				value: _password
			}
		}
		job init:{
			name: _name+"-init"
		}
		job backup:{
			name: _name+"-backup"
			command: "do backup"
		}
		job restore:{
			name: _name+"-restore"
			command: "restore"
		}
	}
	instance name: _name
}






//job init: {
//	name: "foo"
//}
//job init phases: {}

//plan initialize: {
//	action: job.init
//}

//plan backup:{
//	action: job.init
//}
