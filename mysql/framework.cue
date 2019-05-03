package mysql 

deployment mysql spec template spec containers: [{
	image: "mysql:5.7"
	ports: [{
		containerPort: 3306
	}]
}]

version: 5.7

component <Name>: {
	port: uint8,
	image: string
}

component mysql server: {
	image: "mysql:\(version)"
	port: 3306
}

cli mysql: {
	command: "ls"
}

//plan <Name>: {
//	strategy: "serial" | *"parallel"
//}

//plan deploy: {
//}

// Generate a CRD
// with proper
