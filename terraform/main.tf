# --- Data Source: Resource Group ---------------------------------------------
data "ibm_resource_group" "rg" {
  name = var.resource_group_name
}

# --- Code Engine Project -----------------------------------------------------
resource "ibm_code_engine_project" "main" {
  name              = var.ce_project_name
  resource_group_id = data.ibm_resource_group.rg.id
}

# --- Registry Secret (pull private ICR image) --------------------------------
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

# --- Code Engine Application -------------------------------------------------
resource "ibm_code_engine_app" "main" {
  project_id = ibm_code_engine_project.main.project_id
  name       = var.ce_app_name

  image_reference = var.image_url
  image_secret    = ibm_code_engine_secret.icr_pull.name

  scale_min_instances   = var.ce_app_min_scale
  scale_max_instances   = var.ce_app_max_scale
  scale_cpu_limit       = var.ce_app_cpu
  scale_memory_limit    = var.ce_app_memory
  scale_concurrency     = var.ce_app_concurrency
  scale_request_timeout = 300

  dynamic "run_env_variables" {
    for_each = var.app_env_vars
    content {
      type  = "literal"
      name  = run_env_variables.key
      value = run_env_variables.value
    }
  }

  depends_on = [
    ibm_code_engine_secret.icr_pull,
  ]
}
