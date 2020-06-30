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

variable subnetwork_id {
  description = "Subnet ID"
}

variable svc_acct_key_file {
  description = "Path to service account key"
}

variable private_key_path {
  description = "Path to private key used for ssh access"
  default     = "~/.ssh/ubuntu"
}

variable public_key_path {
  description = "Path to public key used for ssh access"
  default     = "~/.ssh/ubuntu.pub"
}

variable instances {
  description = "Number of app instances"
  default     = 1
}
