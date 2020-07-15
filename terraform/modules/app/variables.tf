variable disk_image {
  description = "Disk image for reddit app"
}

variable subnet_id {
  description = "Subnet ID"
}

variable username {
  description = "User name"
  default     = "appuser"
}

variable private_key_path {
  description = "Path to private key used for ssh access"
  default     = "~/.ssh/appuser"
}

variable public_key_path {
  description = "Path to public key used for ssh access"
  default     = "~/.ssh/appuser.pub"
}

variable do_provisioning {
  type        = bool
  description = "Run (true) / skip (false) provisioning scripts"
  default     = false
}

variable db_addr {
  type        = string
  description = "MongoDB address"
}
