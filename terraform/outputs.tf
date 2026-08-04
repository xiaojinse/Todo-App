output "project_id" {
  description = "Code Engine Project ID"
  value       = ibm_code_engine_project.main.project_id
}

output "project_region" {
  description = "Code Engine Project 所在区域"
  value       = ibm_code_engine_project.main.region
}

output "app_endpoint" {
  description = "应用对外暴露的 HTTPS URL"
  value       = "https://${ibm_code_engine_app.main.endpoint_internal != "" ? ibm_code_engine_app.main.endpoint_internal : ibm_code_engine_app.main.name}.${ibm_code_engine_project.main.project_id}.${var.region}.codeengine.appdomain.cloud"
}

output "app_status" {
  description = "应用当前状态"
  value       = ibm_code_engine_app.main.status
}

output "resource_group_id" {
  description = "Resource Group ID"
  value       = data.ibm_resource_group.rg.id
}
