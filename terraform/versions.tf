terraform {
  required_version = ">= 1.5.0"

  cloud {
    organization = "helen-xiao-org-terraform"

    workspaces {
      tags = ["helentestwebsite"]
    }
  }

  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.67.0"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}
