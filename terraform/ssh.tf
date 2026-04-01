resource "hcloud_ssh_key" "default" {
  name       = "superquinquin"
  public_key = var.ssh_public_key
}
