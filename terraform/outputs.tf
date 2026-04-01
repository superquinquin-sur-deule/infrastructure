output "server_ip" {
  description = "Public IP of the server"
  value       = hcloud_server.master.ipv4_address
}

output "ssh_command" {
  description = "SSH command to connect to the server"
  value       = "ssh root@${hcloud_server.master.ipv4_address}"
}

output "kubeconfig_command" {
  description = "Command to retrieve kubeconfig"
  value       = "scp root@${hcloud_server.master.ipv4_address}:/etc/rancher/k3s/k3s.yaml ./kubeconfig"
}