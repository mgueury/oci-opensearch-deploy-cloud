## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_devops_repository" "test_repository" {
  #Required
  name       = "repository"
  project_id = oci_devops_project.test_project.id

  #Optional
  default_branch = "main"
  description    = "repository"

  repository_type = "HOSTED"
}


resource "null_resource" "clonerepo" {

  depends_on = [oci_devops_project.test_project, oci_devops_repository.test_repository]

  provisioner "local-exec" {
    command = "echo '(1) Cleaning local repo: '; rm -rf ${oci_devops_repository.test_repository.name}"
  }

  provisioner "local-exec" {
    command = "echo '(2) Repo to clone: https://devops.scmservice.${var.region}.oci.oraclecloud.com/namespaces/${local.ocir_namespace}/projects/${oci_devops_project.test_project.name}/repositories/${oci_devops_repository.test_repository.name}'"
  }

  #provisioner "local-exec" {
  #  command = "echo '(3) Preparing git-askpass-helper script... '; current_dir=$PWD; chmod +x $current_dir/git-askpass-helper.sh"
  #}

  provisioner "local-exec" {
    command = "echo '(3) Starting git clone command... '; echo 'Username: Before' ${var.oci_username}; echo 'Username: After' ${local.encode_user}; git clone https://${local.encode_user}:${local.encode_token}@devops.scmservice.${var.region}.oci.oraclecloud.com/namespaces/${local.ocir_namespace}/projects/${oci_devops_project.test_project.name}/repositories/${oci_devops_repository.test_repository.name};"
  }

  provisioner "local-exec" {
    command = "echo '(4) Finishing git clone command: '; ls -latr ${oci_devops_repository.test_repository.name}"
  }
}

resource "null_resource" "clonefromgithub" {

  provisioner "local-exec" {
    command = "rm -rf ./${local.git_repo_name}"
  }

  provisioner "local-exec" {
    command = "git clone ${local.git_repo};"
  }
}

resource "null_resource" "copyfiles" {

  depends_on = [null_resource.clonerepo]

  provisioner "local-exec" {
    command = "rm -rf ${local.git_repo_name}/.git; cp -pr ${local.git_repo_name}/* ${oci_devops_repository.test_repository.name}/; cd .."
  }
}

resource "null_resource" "pushcode" {

  depends_on = [null_resource.copyfiles]

  provisioner "local-exec" {
    command = "cd ./${oci_devops_repository.test_repository.name}; git config --local user.email 'test@example.com'; git config --local user.name '${var.oci_username}';git add .; git commit -m 'added latest files'; git push origin main"
  }
}

locals {
  git_repo    = "https://github.com/mgueury/oci-opensearch-devops.git"
  git_repo_name = "oci-opensearch-devops"
  # OCI DevOps GIT login is tenancy/username
  encode_user = urlencode("${data.oci_identity_tenancy.tenant_details.name}/${var.oci_username}")
  encode_token  = urlencode(var.oci_user_authtoken)
}
