# Local Values

locals {
  owners      = var.business-division
  environment = var.environment
  name        = "${var.business-division}-${var.environment}"
  #name2 = "${local.owners}-${local.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}