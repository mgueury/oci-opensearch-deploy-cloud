resource "oci_kms_vault" "opensearch_kms" {
  compartment_id = var.compartment_ocid
  display_name = "opensearch-vault"
  vault_type   = "DEFAULT"
}

resource "oci_kms_key" "opensearch_key" {
  #Required
  compartment_id      = var.compartment_ocid
  display_name        = "opensearch-key"
  management_endpoint = oci_kms_vault.opensearch_kms.management_endpoint

  key_shape {
    #Required
    algorithm = "AES"
    length    = 32
  }
}

resource "oci_vault_secret" "opensearch_secret_username" {
  #Required
  compartment_id = var.compartment_ocid
  secret_content {
    #Required
    content_type = "BASE64"

    #Optional
    content = base64encode( var.oci_username )
    name    = "name"
    stage   = "CURRENT"
  }
  key_id = oci_kms_key.opensearch_key.id
  secret_name = "opensearch-key-user"
  vault_id    = oci_kms_vault.opensearch_kms.id
}

resource "oci_vault_secret" "opensearch_secret_token" {
  #Required
  compartment_id = var.compartment_ocid
  secret_content {
    #Required
    content_type = "BASE64"

    #Optional
    content = base64encode( var.oci_user_authtoken )
    name    = "name"
    stage   = "CURRENT"
  }
  key_id = oci_kms_key.opensearch_key.id
  secret_name = "opensearch-key-user"
  vault_id    = oci_kms_vault.opensearch_kms.id
}


