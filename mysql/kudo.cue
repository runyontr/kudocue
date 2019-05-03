package mysql

service <Name>: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: Name
		labels: {
			app:       Name
			domain:    "prod"
		}
	}
	spec: {
		// Any port has the following properties.
		ports: [...{
			port:     int
			protocol: *"TCP" | "UDP"
			name:     string | *"client"
		}]
		selector: metadata.labels // we want those to be the same
	}
}



daemonSet <Name>: _spec & {
	apiVersion: "extensions/v1beta1"
	kind:       "DaemonSet"
	_name:      Name
}

statefulSet <Name>: _spec & {
	apiVersion: "apps/v1beta1"
	kind:       "StatefulSet"
	_name:      Name
}

deployment <Name>: _spec & {
	apiVersion: "extensions/v1beta1"
	kind:       "Deployment"
	_name:      Name
	spec replicas: *1 | int
}

configMap <Name>: {
	metadata name: Name
}


_spec: {
	_name: string
	metadata name: _name
	spec template: {
		metadata labels: {
			app:       _name
			domain:    "prod"
		}
		spec containers: [{name: _name}]
	}
}

// Define the _export option and set the default to true
// for all ports defined in all containers.
_spec spec template spec containers: [...{
	ports: [...{
		_export: *true | false // include the port in the service
	}]
}]

service "\(k)": {
	spec selector: v.spec.template.metadata.labels

	spec ports: [ {
		Port = p.containerPort // Port is an alias
		port:       *Port | int
		targetPort: *Port | int
	} for c in v.spec.template.spec.containers
		for p in c.ports
		if p._export ]

} for x in [deployment] for k, v in x




objects: [ x for v in objectSets for x in v ]

objectSets: [
    service,
    deployment
]

plan <Name> phases: {
	strategy: "parallel"
	name: Name
	phases: [{
		strategy: "parallel"
		name: Name
		steps: [{
			strategy: "parallel"
			name: Name
			tasks: [{
				name: x.metadata.name
				object: x
			 } for x in objects]
		}]
	}]
}
	
plan deploy: {}
plan update: {}
plan upgrade: {}
