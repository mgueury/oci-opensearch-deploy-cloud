## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "private_key_path" {}
variable "region" {}

variable "app_name" {
  default     = "DevOps"
  description = "Application name. Will be used as prefix to identify resources"
}

variable "oci_username" {}
variable "oci_user_authtoken" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1.2"
}

variable "project_logging_config_retention_period_in_days" {
  default = 30
}

variable "project_description" {
  default = "DevOps CI/CD Sample Project"
}

variable "repository_default_branch" {
  default = "main"
}

variable "repository_description" {
  default = "nodejs sample application"
}

variable "git_repo" {
  default = "https://github.com/oracle-quickstart/oci-devops-node.git"
}

variable "git_repo_name" {
  default = "oci-devops-node"
}

variable "build_pipeline_stage_build_pipeline_stage_predecessor_collection_items_id" {
  default = "id"
}

variable "build_pipeline_stage_image" {
  default = "OL7_X86_64_STANDARD_10"
}

variable "build_pipeline_stage_wait_criteria_wait_duration" {
  default = "waitDuration"
}

variable "build_pipeline_stage_wait_criteria_wait_type" {
  default = "ABSOLUTE_WAIT"
}

/*
variable "registry_display_name" {
  default = "node-express-getting-starter"
}
*/

variable "container_repository_is_public" {
  default = true
}

locals {
  ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.current_region.regions[0], "key")), ".ocir.io"])
  #ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.home_region.regions[0], "key")), ".ocir.io"])
  #ocir_namespace = lookup(data.oci_identity_tenancy.oci_tenancy, "name" )
  ocir_namespace = lookup(data.oci_objectstorage_namespace.ns, "namespace")
}

#variable "ocir_region" {
# default = "iad"}




variable "repository_repository_type" {
  default = "HOSTED"
}

variable "deploy_pipeline_deploy_pipeline_parameters_items_default_value" {
  default = "example"
}

variable "deploy_pipeline_deploy_pipeline_parameters_items_description" {
  default = "exampleapp"
}

variable "deploy_pipeline_deploy_pipeline_parameters_items_name" {
  default = "namespace"
}

variable "build_pipeline_stage_is_pass_all_parameters_enabled" {
  default = true
}

