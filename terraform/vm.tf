resource "hcloud_server" "master" {
  name        = "superquinquin-master-0"
  image       = "ubuntu-24.04"
  server_type = var.server_type
  location    = var.location

  ssh_keys     = [hcloud_ssh_key.default.id]
  firewall_ids = [hcloud_firewall.k3s.id]

  network {
    network_id = hcloud_network.k3s.id
    ip         = "10.0.1.10"
  }

  user_data = templatefile("${path.module}/templates/cloud-init.yaml.tftpl", {
    k3s_token  = random_password.k3s_token.result
    private_ip = "10.0.1.10"
  })

  depends_on = [hcloud_network_subnet.k3s]
}