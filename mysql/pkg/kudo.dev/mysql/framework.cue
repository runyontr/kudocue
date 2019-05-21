package mysql 

import "kudo.dev/core"

_kudo: core

//Update the default deployment to have a particular image/port
//_kudo deployment <Name> spec template spec containers: [{
//		image: "mysql:5.7"
//		ports: [{
//			containerPort: 3306
			export: true
		}]
	}]

//Update default Jobs
_kudo job <Name>: {
	image: "mysql:5.7"
	command: "create table"
	env: framework.password
}

_kudo job init: {}
_kudo job backup: {}
_kudo job restore: {}
_kudo deployment server: {}

//Instance of a mysql framework
framework: _kudo.framework._base & {
	_name: string
	password: *"default" | string

	task deploy: [{
		framework.objects.deployment.server,
		framework.objects.job.init
	}]
	task backup:[{
		framework.objects.job.backup,
	}]
	task restore: [{
		framework.objects.job.restore,
	}]
	objects: {
		deployment server: {
			instance_name: _name
			env: {
				name: "MYSQL_ROOT_PASSWORD"
				value: password
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

default= framework
{foobar: default }



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
