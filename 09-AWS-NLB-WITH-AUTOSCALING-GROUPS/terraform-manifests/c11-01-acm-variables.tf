# Implement ACM certificage in ACM and Validate

# Phosware Domain Certificate ARN - *.phoswarecomputing.com
variable "phosware_domain_certificate_arn" {
  description = "Phosware Computing wild card certificate ARN issued by ACM"
  type        = string
  default     = "arn:aws:acm:us-east-1:457373170191:certificate/a75a607a-c411-48ae-b45c-33f5507576db"
}

