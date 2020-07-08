variable cloud_id {
  description = "Cloud"
}

variable folder_id {
  description = "Folder"
}

variable image_id {
  description = "Image"
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
  default     = "fd8grn64stm2cahp9ah0"
  #  default     = "fd8bp3upajf1gfk5eesu"
}

variable app_disk_image {
  description = "Disk image id for reddit app"
  default     = "fd8g38a4u60ra7pq28ho"
}
