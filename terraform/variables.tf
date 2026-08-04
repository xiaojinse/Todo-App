# --- IBM Cloud Authentication ------------------------------------------------
variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key. Pass via TF_VAR_ibmcloud_api_key environment variable instead of writing it in a tfvars file."
  type        = string
  sensitive   = true
}

# --- Base Configuration ------------------------------------------------------
variable "region" {
  description = "IBM Cloud region, e.g. us-south, jp-tok, eu-de"
  type        = string
  default     = "us-south"
}

variable "resource_group_name" {
  description = "IBM Cloud Resource Group name"
  type        = string
  default     = "default"
}

# --- Code Engine Configuration -----------------------------------------------
variable "ce_project_name" {
  description = "Code Engine Project name (must be globally unique)"
  type        = string
}

variable "ce_app_name" {
  description = "Code Engine Application name"
  type        = string
  default     = "helentestwebsite"
}

variable "ce_app_min_scale" {
  description = "Minimum number of app instances (0 = scale to zero)"
  type        = number
  default     = 0
}

variable "ce_app_max_scale" {
  description = "Maximum number of app instances"
  type        = number
  default     = 5
}

variable "ce_app_cpu" {
  description = "vCPU per instance, e.g. 0.25, 0.5, 1"
  type        = string
  default     = "0.25"
}

variable "ce_app_memory" {
  description = "Memory per instance, e.g. 0.5G, 1G, 2G"
  type        = string
  default     = "0.5G"
}

variable "ce_app_port" {
  description = "Container listening port (must match Dockerfile EXPOSE and nginx.conf)"
  type        = number
  default     = 8080
}

variable "ce_app_concurrency" {
  description = "Maximum concurrent requests per instance"
  type        = number
  default     = 100
}

# --- Container Image ---------------------------------------------------------
variable "image_url" {
  description = "Full container image URL, e.g. jp.icr.io/<namespace>/helentestwebsite:latest"
  type        = string
}

variable "icr_secret_name" {
  description = "Name of the Registry Secret in Code Engine used to pull the ICR image"
  type        = string
  default     = "icr-pull-secret"
}

variable "registry_server" {
  description = "Container registry server, e.g. us.icr.io, jp.icr.io, de.icr.io"
  type        = string
  default     = "us.icr.io"
}

variable "registry_username" {
  description = "Registry username (always 'iamapikey' for ICR)"
  type        = string
  default     = "iamapikey"
}

variable "registry_password" {
  description = "Registry password (IBM Cloud API Key for ICR). Pass via TF_VAR_registry_password environment variable."
  type        = string
  sensitive   = true
}

# --- Application Environment Variables (optional) ----------------------------
variable "app_env_vars" {
  description = "Map of environment variables to pass to the Code Engine application"
  type        = map(string)
  default     = {}
}
