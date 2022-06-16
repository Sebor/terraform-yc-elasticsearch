output "cluster_name" {
  value       = yandex_mdb_elasticsearch_cluster.this.name
  description = "Elasticsearch cluster name"
}

output "cluster_id" {
  value       = yandex_mdb_elasticsearch_cluster.this.id
  description = "Elasticsearch cluster ID"
}

output "cluster_service_account_id" {
  value       = yandex_mdb_elasticsearch_cluster.this.service_account_id
  description = "Elasticsearch cluster service account ID"
}

output "cluster_data_hosts" {
  value = [
    for host in yandex_mdb_elasticsearch_cluster.this.host : {
      name      = host.name
      fqdn      = host.fqdn
      zone      = host.zone
      subnet_id = host.subnet_id
    } if host.type == "DATA_NODE"
  ]
  description = "A list of Elasticsearch DATA hosts"
}

output "cluster_master_hosts" {
  value = [
    for host in yandex_mdb_elasticsearch_cluster.this.host : {
      name      = host.name
      fqdn      = host.fqdn
      zone      = host.zone
      subnet_id = host.subnet_id
    } if host.type == "MASTER_NODE"
  ]
  description = "A list of Elasticsearch MASTER hosts"
}

output "cluster_cname_data_hosts" {
  value = [
    for host in yandex_dns_recordset.data_hosts.*.name :
    trimsuffix(host, ".")
  ]
  description = "A list of Elasticsearch CNAME DATA hosts"
}

output "cluster_cname_master_hosts" {
  value = [
    for host in yandex_dns_recordset.master_hosts.*.name :
    trimsuffix(host, ".")
  ]
  description = "A list of Elasticsearch CNAME MASTER hosts"
}
