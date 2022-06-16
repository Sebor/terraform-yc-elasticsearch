resource "yandex_mdb_elasticsearch_cluster" "this" {
  name        = var.cluster_name
  description = var.cluster_description
  environment = var.cluster_environment
  folder_id   = var.cluster_folder_id

  network_id         = var.cluster_vpc_id
  security_group_ids = var.cluster_security_group_ids

  service_account_id  = var.cluster_service_account_id
  deletion_protection = var.cluster_deletion_protection

  config {
    version        = var.cluster_version
    edition        = var.cluster_edition
    plugins        = var.cluster_plugins
    admin_password = var.cluster_admin_password

    data_node {
      resources {
        resource_preset_id = var.data_node_resources["resource_preset_id"]
        disk_type_id       = var.data_node_resources["disk_type_id"]
        disk_size          = var.data_node_resources["disk_size"]
      }
    }

    master_node {
      resources {
        resource_preset_id = var.master_node_resources["resource_preset_id"]
        disk_type_id       = var.master_node_resources["disk_type_id"]
        disk_size          = var.master_node_resources["disk_size"]
      }
    }
  }

  # Data hosts
  dynamic "host" {
    for_each = var.data_hosts

    content {
      name             = host.value.name
      zone             = host.value.zone
      subnet_id        = host.value.subnet_id
      type             = "DATA_NODE"
      assign_public_ip = var.cluster_assign_public_ip
    }
  }

  # Master hosts
  dynamic "host" {
    for_each = var.master_hosts

    content {
      name             = host.value.name
      zone             = host.value.zone
      subnet_id        = host.value.subnet_id
      type             = "MASTER_NODE"
      assign_public_ip = var.cluster_assign_public_ip
    }
  }

  dynamic "maintenance_window" {
    for_each = var.cluster_maintenance_window != null ? [1] : []

    content {
      type = lookup(var.cluster_maintenance_window, "type")
      day  = lookup(var.cluster_maintenance_window, "day")
      hour = lookup(var.cluster_maintenance_window, "hour")
    }
  }

  labels = var.labels
}

resource "yandex_dns_recordset" "data_hosts" {
  count = var.cluster_elasticsearch_cname != null && var.internal_dns_zone_id != null && var.internal_dns_zone_name != null ? length(var.data_hosts) : 0

  zone_id = var.internal_dns_zone_id
  name    = "${var.cluster_elasticsearch_cname}-data-${count.index + 1}.${var.internal_dns_zone_name}."
  type    = "CNAME"
  ttl     = 360
  data    = [[for i in yandex_mdb_elasticsearch_cluster.this.host : i.fqdn if i.type == "DATA_NODE"][count.index]]
}

resource "yandex_dns_recordset" "master_hosts" {
  count = var.cluster_elasticsearch_cname != null && var.internal_dns_zone_id != null && var.internal_dns_zone_name != null ? length(var.master_hosts) : 0

  zone_id = var.internal_dns_zone_id
  name    = "${var.cluster_elasticsearch_cname}-master-${count.index + 1}.${var.internal_dns_zone_name}."
  type    = "CNAME"
  ttl     = 360
  data    = [[for i in yandex_mdb_elasticsearch_cluster.this.host : i.fqdn if i.type == "MASTER_NODE"][count.index]]
}
