# ─── IBM Cloud 认证 ───────────────────────────────────────────────────────────
variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key（建议通过环境变量 TF_VAR_ibmcloud_api_key 传入，不要写入 tfvars 文件）"
  type        = string
  sensitive   = true
}

# ─── 基础配置 ─────────────────────────────────────────────────────────────────
variable "region" {
  description = "IBM Cloud 区域，例如 us-south、jp-tok、eu-de"
  type        = string
  default     = "us-south"
}

variable "resource_group_name" {
  description = "IBM Cloud Resource Group 名称"
  type        = string
  default     = "default"
}

# ─── Code Engine 配置 ─────────────────────────────────────────────────────────
variable "ce_project_name" {
  description = "Code Engine Project 名称（全局唯一）"
  type        = string
}

variable "ce_app_name" {
  description = "Code Engine Application 名称"
  type        = string
  default     = "helentestwebsite"
}

variable "ce_app_min_scale" {
  description = "应用最小实例数（0 表示可以缩容到零）"
  type        = number
  default     = 0
}

variable "ce_app_max_scale" {
  description = "应用最大实例数"
  type        = number
  default     = 5
}

variable "ce_app_cpu" {
  description = "每个实例的 vCPU，例如 0.25、0.5、1"
  type        = string
  default     = "0.25"
}

variable "ce_app_memory" {
  description = "每个实例的内存，例如 0.5G、1G、2G"
  type        = string
  default     = "0.5G"
}

variable "ce_app_port" {
  description = "容器监听端口（与 Dockerfile EXPOSE 及 nginx.conf 保持一致）"
  type        = number
  default     = 8080
}

variable "ce_app_concurrency" {
  description = "每个实例的最大并发请求数"
  type        = number
  default     = 100
}

# ─── 容器镜像 ─────────────────────────────────────────────────────────────────
variable "image_url" {
  description = "完整的容器镜像 URL，例如 icr.io/<namespace>/helentestwebsite:latest"
  type        = string
}

variable "icr_secret_name" {
  description = "Code Engine 中拉取 ICR 镜像所用的 Registry Secret 名称"
  type        = string
  default     = "icr-pull-secret"
}

variable "registry_server" {
  description = "镜像仓库地址，例如 us.icr.io、jp.icr.io、de.icr.io 或 icr.io"
  type        = string
  default     = "us.icr.io"
}

variable "registry_username" {
  description = "镜像仓库用户名（ICR 通常为 iamapikey）"
  type        = string
  default     = "iamapikey"
}

variable "registry_password" {
  description = "镜像仓库密码（ICR 即 IBM Cloud API Key，建议通过环境变量传入）"
  type        = string
  sensitive   = true
}

# ─── 应用环境变量（可选）─────────────────────────────────────────────────────
variable "app_env_vars" {
  description = "传递给 Code Engine 应用的环境变量 map"
  type        = map(string)
  default     = {}
}
