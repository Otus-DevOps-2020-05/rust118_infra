variable cloud_id {
  description = "Cloud"
}

variable folder_id {
  description = "Folder"
}

variable region {
  description = "Region"
  default     = "ru-central1"
}

variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}

variable subnet_id {
  description = "Subnet ID"
}

variable svc_acct_key_file {
  description = "Path to service account key"
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

variable aws_credentials_path {
  description = "Path to AWS credentials file"
  default     = "~/.aws/credentials"
}

variable db_disk_image {
  description = "Disk image id for reddit db"
  default     = "fd863k9qrmhh0mirci17"
}

variable app_disk_image {
  description = "Disk image id for reddit app"
  default     = "fd85icaoprlonf51arg3"
}
