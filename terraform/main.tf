# ─── 数据源：Resource Group ───────────────────────────────────────────────────
data "ibm_resource_group" "rg" {
  name = var.resource_group_name
}

# ─── Code Engine Project ──────────────────────────────────────────────────────
resource "ibm_code_engine_project" "main" {
  name              = var.ce_project_name
  resource_group_id = data.ibm_resource_group.rg.id
}

# ─── Registry Secret（拉取 ICR 私有镜像）──────────────────────────────────────
resource "ibm_code_engine_secret" "icr_pull" {
  project_id = ibm_code_engine_project.main.project_id
  name       = var.icr_secret_name
  format     = "registry"

  data = {
    username = var.registry_username
    password = var.registry_password
    server   = var.registry_server
    email    = "unused@example.com"
  }
}

# ─── Code Engine Application ──────────────────────────────────────────────────
resource "ibm_code_engine_app" "main" {
  project_id = ibm_code_engine_project.main.project_id
  name       = var.ce_app_name

  image_reference = var.image_url
  image_secret    = ibm_code_engine_secret.icr_pull.name

  scale_min_instances        = var.ce_app_min_scale
  scale_max_instances        = var.ce_app_max_scale
  scale_cpu_limit            = var.ce_app_cpu
  scale_memory_limit         = var.ce_app_memory
  scale_concurrency          = var.ce_app_concurrency
  scale_request_timeout      = 300

  # 容器端口
  probe_liveness = []
  probe_readiness = []

  run_env_variables = [
    for k, v in var.app_env_vars : {
      type  = "literal"
      name  = k
      value = v
    }
  ]

  depends_on = [
    ibm_code_engine_secret.icr_pull,
  ]
}
