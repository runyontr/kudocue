package mysql


objects: [ x for v in objectSets for x in v ]

objectSets: [
    service,
    deployment,
    plan
]