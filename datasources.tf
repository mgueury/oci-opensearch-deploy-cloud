## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Gets home and current regions
data "oci_identity_tenancy" "tenant_details" {
  tenancy_id = var.tenancy_ocid
  provider   = oci.current_region
}

data "oci_identity_regions" "home_region" {
  filter {
    name   = "key"
    values = [data.oci_identity_tenancy.tenant_details.home_region_key]
  }

  provider = oci.current_region
}

data "oci_identity_regions" "current_region" {
  filter {
    name   = "name"
    values = [var.region]
  }
  provider = oci.current_region
}

# Randoms
resource "random_string" "id" {
  length  = 4
  special = false
}

resource "random_id" "tag" {
  byte_length = 2
}


