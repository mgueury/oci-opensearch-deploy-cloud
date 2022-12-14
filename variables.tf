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


variable "oci_username" {
  default="oracleidentitycloudservice/name@domain.com"
}
variable "oci_user_authtoken" {}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1.2"
}

locals {
  ocir_docker_repository = join("", [lower(lookup(data.oci_identity_regions.current_region.regions[0], "key")), ".ocir.io"])
  ocir_namespace = lookup(data.oci_objectstorage_namespace.ns, "namespace")
}



