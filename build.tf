resource "oci_devops_build_pipeline" "test_build_pipeline" {

  #Required
  project_id = oci_devops_project.test_project.id

  description  = "Build pipeline"
  display_name = "build-pipeline"

  build_pipeline_parameters {
    items {
      default_value = var.compartment_ocid
      description   = ""
      name          = "TF_VAR_compartment_ocid"
    }
    items {
      default_value = var.region
      description   = ""
      name          = "TF_VAR_region"
    }
  }
}

#############################################################################

resource "oci_devops_build_pipeline_stage" "test_build_pipeline_stage" {
  #Required
  build_pipeline_id = oci_devops_build_pipeline.test_build_pipeline.id
  build_pipeline_stage_predecessor_collection {
    #Required
    items {
      #Required
      id = oci_devops_build_pipeline.test_build_pipeline.id
    }
  }
  build_pipeline_stage_type = "BUILD"
  
  #Optional
  build_source_collection {

    #Optional
    items {
      #Required
      connection_type = "DEVOPS_CODE_REPOSITORY"

      #Optional
      branch = "main"
      # connection_id  = oci_devops_connection.test_connection.id
      name           = "build"
      repository_id  = oci_devops_repository.test_repository.id
      repository_url = "https://devops.scmservice.${var.region}.oci.oraclecloud.com/namespaces/${local.ocir_namespace}/projects/${oci_devops_project.test_project.name}/repositories/${oci_devops_repository.test_repository.name}"
    }
  }

  build_spec_file                    = ""
  description                        = "Build stage"
  display_name                       = "build-stage"
  image                              = "OL7_X86_64_STANDARD_10"
  stage_execution_timeout_in_seconds = "36000"
  wait_criteria {
    #Required
    wait_duration = "waitDuration"
    wait_type     = "ABSOLUTE_WAIT"
  }
}

#############################################################################

resource "null_resource" "sleep_before_build" {
  depends_on = [oci_devops_build_pipeline_stage.test_build_pipeline_stage]
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

resource "oci_devops_build_run" "test_build_run_1" {
  depends_on = [null_resource.sleep_before_build]
  #Required
  build_pipeline_id = oci_devops_build_pipeline.test_build_pipeline.id
  #Optional
  display_name = "build-run-${random_id.tag.hex}"
}

#############################################################################

