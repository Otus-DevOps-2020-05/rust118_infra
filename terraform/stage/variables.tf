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

variable aws_credentials_path {
  description = "Path to AWS credentials file"
  default     = "~/.aws/credentials"
}
