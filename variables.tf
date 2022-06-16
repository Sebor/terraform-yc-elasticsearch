variable "cluster_name" {
  type        = string
  description = "Elasticsearch cluster name and name prefix for cluster resources"
}

variable "cluster_admin_password" {
  type        = string
  description = "Elasticsearch cluster admin password"
}

variable "cluster_description" {
  type        = string
  default     = "Elasticsearch cluster managed by terraform"
  description = "A description of the Elasticsearch cluster"
}

variable "cluster_folder_id" {
  type        = string
  default     = null
  description = "The ID of the folder that the Elasticsearch cluster belongs to"
}

variable "cluster_plugins" {
  type        = set(string)
  default     = null
  description = "A set of Elasticsearch plugins to install"
}

variable "cluster_environment" {
  type        = string
  default     = "PRODUCTION"
  description = <<EOF
  Deployment environment of the Elasticsearch cluster.
  Can be either PRESTABLE or PRODUCTION. The default is PRODUCTION
  EOF

  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.cluster_environment)
    error_message = "Environment must be 'PRODUCTION' or 'PRESTABLE'."
  }
}

variable "cluster_edition" {
  type        = string
  default     = "basic"
  description = "Edition of Elasticsearch"

  validation {
    condition     = contains(["basic", "gold", "platinum"], var.cluster_edition)
    error_message = "Edidtion must be 'basic', 'gold' or 'platinum'."
  }
}

variable "cluster_vpc_id" {
  type        = string
  description = "ID of the network, to which the Elasticsearch cluster belongs"
}

variable "cluster_version" {
  type        = string
  default     = null
  description = "Version of the Elasticsearch cluster"
}

variable "cluster_assign_public_ip" {
  type        = bool
  default     = false
  description = "Determines whether each node will be assigned a public IP address. The default is false"
}

variable "cluster_deletion_protection" {
  type        = bool
  default     = null
  description = "Inhibits deletion of the cluster"
}

variable "cluster_service_account_id" {
  type        = string
  default     = null
  description = "ID of the service account authorized for this cluster"
}

variable "cluster_security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to be assigned to cluster"
}

variable "data_node_resources" {
  type = object({
    resource_preset_id = string
    disk_type_id       = string
    disk_size          = number
  })
  description = "Resources allocated to hosts of the Elasticsearch data nodes subcluster"
}

variable "master_node_resources" {
  type = object({
    resource_preset_id = string
    disk_type_id       = string
    disk_size          = number
  })
  default = {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }
  description = "Resources allocated to hosts of the Elasticsearch master nodes subcluster"
}

variable "data_hosts" {
  type        = any
  description = <<EOF
  A list of DATA hosts.
  Example:
  ```
  data_hosts = [
    {
      name      = "dnode1"
      zone      = "ru-central1-a"
      subnet_id = "dfsdfdfsfsd343434"
    },
    {
      name      = "dnode2"
      zone      = "ru-central1-b"
      subnet_id = "1fs567hfsd343434"
    }
  ]
  ```
  EOF
}

variable "master_hosts" {
  type        = any
  default     = []
  description = <<EOF
  A list of MASTER hosts.
  Example:
  ```
  master_hosts = [
    {
      name      = "mnode1"
      zone      = "ru-central1-a"
      subnet_id = "dfsdfdfsfsd343434"
    },
    {
      name      = "mnode2"
      zone      = "ru-central1-b"
      subnet_id = "1fs567hfsd343434"
    }
  ]
  ```
  EOF
}

variable "cluster_maintenance_window" {
  type        = map(any)
  default     = null
  description = <<EOF
  Maintenance policy of the Elasticsearch cluster
  Example:
  ```
  cluster_maintenance_window = {
      type = "WEEKLY"
      day  = "MON
      hour = 17
  }
  ```
  EOF
}

variable "cluster_elasticsearch_cname" {
  type        = string
  default     = null
  description = "Internal CNAME for Elasticsearch hosts"
}

variable "internal_dns_zone_id" {
  type        = string
  default     = null
  description = "Internal DNS zone ID for Elasticsearch hosts"
}

variable "internal_dns_zone_name" {
  type        = string
  default     = null
  description = "Internal DNS zone name for Elasticsearch hosts"
}

variable "labels" {
  type        = map(any)
  default     = {}
  description = "A set of key/value label pairs to assign to the Kubernetes cluster resources"
}
