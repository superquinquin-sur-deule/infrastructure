variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
}

variable "server_type" {
  description = "Hetzner server type"
  type        = string
  default     = "cx52"
}

variable "location" {
  description = "Hetzner datacenter location"
  type        = string
  default     = "fsn1"
}

variable "s3_access_key" {
  description = "Hetzner S3 access key"
  type        = string
  sensitive   = true
}

variable "s3_secret_key" {
  description = "Hetzner S3 secret key"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "Domain name for the cluster"
  type        = string
}
