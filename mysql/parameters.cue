package mysql 

password: string | *"somethign"
deployment <Name> spec template spec containers: [{env: [{name: "MYSQL_ROOT_PASSWORD", value: password}] }]

//  Kind: Cue
//  ApiVersion: MySQL
//  spec: |
//   password: string | *"somethign"
//   deployment <Name> spec template spec containers: [{env: [{name: "MYSQL_ROOT_PASSWORD", value: password}] }]


// Framewokr Developer:
// Cue ---kudoctl----> CRDs (with Cue Embedded) --- Kudo Controller ---> Render PlanExecutions

// Request:
// 1) List of FrameworkDeveloper generated objects
// 2) List of CRDs taht get created as a result of 1)
// 3) Cue code that gets executed by the controller