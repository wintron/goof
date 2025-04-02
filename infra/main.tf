resource "null_resource" "hello" {
  provisioner "local-exec" {
    command = "echo ${var.greeting}"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
