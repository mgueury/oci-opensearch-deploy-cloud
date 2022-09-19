## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "compartment_ocid" {}
# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "private_key_path" {}
variable "region" {}

variable "app_name" {
  default     = "opensearch"
  description = "Application name. Will be used as prefix to identify resources"
}

variable "oci_username" {}
variable "oci_user_authtoken" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1.2"
}

variable "git_repo" {
  default = "https://github.com/mgueury/oci-opensearch-devops.git"
}

variable "git_repo_name" {
  default = "oci-opensearch-devops"
}

locals {
  ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.current_region.regions[0], "key")), ".ocir.io"])
  #ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.home_region.regions[0], "key")), ".ocir.io"])
  #ocir_namespace = lookup(data.oci_identity_tenancy.oci_tenancy, "name" )
  ocir_namespace = lookup(data.oci_objectstorage_namespace.ns, "namespace")
}

#variable "ocir_region" {
# default = "iad"}



