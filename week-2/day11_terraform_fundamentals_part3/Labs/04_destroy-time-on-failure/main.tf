resource "null_resource" "destroy_time_demo" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "echo Resource created"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo Resource is being destroyed"
  }
}

resource "null_resource" "on_failure_demo" {
  provisioner "local-exec" {
    command    = "invalid-command"
    on_failure = continue
  }

  provisioner "local-exec" {
    command = "echo Terraform continues because on_failure is continue"
  }
}
