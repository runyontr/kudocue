package instance

import "kudo.dev/mysql"

instance framework database: mysql.framework & {
    password: "kitchen"
    _name: "database"
}


