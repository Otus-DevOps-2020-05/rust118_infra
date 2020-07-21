variable disk_image {
  description = "Disk image id for reddit db"
  default     = "fd8v8f8hlggmssdmj8mt"
}

variable subnet_id {
  description = "Subnet ID"
}

variable username {
  description = "User name"
  default     = "ubuntu"
}

variable private_key_path {
  description = "Path to private key used for ssh access"
  default     = "~/.ssh/ubuntu"
}

variable public_key_path {
  description = "Path to public key used for ssh access"
  default     = "~/.ssh/ubuntu.pub"
}
