# RDS DB Variables

# DB Name
variable "db_name" {
  description = "AWS RDS Database Name"
  type        = string
}

# DB Name
variable "db_instance_identifier" {
  description = "AWS RDS Database Instance Identifier"
  type        = string
}


# DB Name
variable "db_username" {
  description = "AWS RDS Database Administrator Username"
  type        = string
}


# DB Name
variable "db_password" {
  description = "AWS RDS Database Administrator Password"
  type        = string
  sensitive   = true
}

# DB Port
variable "db_port" {
  description = "AWS RDS Database Administrator Password"
  type        = number
  sensitive   = true
}

