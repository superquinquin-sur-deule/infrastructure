resource "null_resource" "s3_bucket" {
  provisioner "local-exec" {
    environment = {
      AWS_ACCESS_KEY_ID     = var.s3_access_key
      AWS_SECRET_ACCESS_KEY = var.s3_secret_key
    }
    command = <<-EOT
      aws s3api create-bucket \
        --bucket pgbackrest-${var.domain} \
        --endpoint-url https://fsn1.your-objectstorage.com \
        --region fsn1
    EOT
  }
}
