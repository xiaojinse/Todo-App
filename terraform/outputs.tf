output "project_id" {
  description = "Code Engine Project ID"
  value       = ibm_code_engine_project.main.project_id
}

output "project_region" {
  description = "Region where the Code Engine Project is deployed"
  value       = ibm_code_engine_project.main.region
}

output "app_endpoint" {
  description = "Public HTTPS URL of the deployed application"
  value       = "https://${ibm_code_engine_app.main.endpoint_internal != "" ? ibm_code_engine_app.main.endpoint_internal : ibm_code_engine_app.main.name}.${ibm_code_engine_project.main.project_id}.${var.region}.codeengine.appdomain.cloud"
}

output "app_status" {
  description = "Current status of the Code Engine application"
  value       = ibm_code_engine_app.main.status
}

output "resource_group_id" {
  description = "Resource Group ID"
  value       = data.ibm_resource_group.rg.id
}
