# Elasticsearch

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.75 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.75 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_dns_recordset.data_hosts](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_recordset) | resource |
| [yandex_dns_recordset.master_hosts](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_recordset) | resource |
| [yandex_mdb_elasticsearch_cluster.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_elasticsearch_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_admin_password"></a> [cluster\_admin\_password](#input\_cluster\_admin\_password) | Elasticsearch cluster admin password | `string` | n/a | yes |
| <a name="input_cluster_assign_public_ip"></a> [cluster\_assign\_public\_ip](#input\_cluster\_assign\_public\_ip) | Determines whether each node will be assigned a public IP address. The default is false | `bool` | `false` | no |
| <a name="input_cluster_deletion_protection"></a> [cluster\_deletion\_protection](#input\_cluster\_deletion\_protection) | Inhibits deletion of the cluster | `bool` | `null` | no |
| <a name="input_cluster_description"></a> [cluster\_description](#input\_cluster\_description) | A description of the Elasticsearch cluster | `string` | `"Elasticsearch cluster managed by terraform"` | no |
| <a name="input_cluster_edition"></a> [cluster\_edition](#input\_cluster\_edition) | Edition of Elasticsearch | `string` | `"basic"` | no |
| <a name="input_cluster_elasticsearch_cname"></a> [cluster\_elasticsearch\_cname](#input\_cluster\_elasticsearch\_cname) | Internal CNAME for Elasticsearch hosts | `string` | `null` | no |
| <a name="input_cluster_environment"></a> [cluster\_environment](#input\_cluster\_environment) | Deployment environment of the Elasticsearch cluster.<br>  Can be either PRESTABLE or PRODUCTION. The default is PRODUCTION | `string` | `"PRODUCTION"` | no |
| <a name="input_cluster_folder_id"></a> [cluster\_folder\_id](#input\_cluster\_folder\_id) | The ID of the folder that the Elasticsearch cluster belongs to | `string` | `null` | no |
| <a name="input_cluster_maintenance_window"></a> [cluster\_maintenance\_window](#input\_cluster\_maintenance\_window) | Maintenance policy of the Elasticsearch cluster<br>  Example:<pre>cluster_maintenance_window = {<br>      type = "WEEKLY"<br>      day  = "MON<br>      hour = 17<br>  }</pre> | `map(any)` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Elasticsearch cluster name and name prefix for cluster resources | `string` | n/a | yes |
| <a name="input_cluster_plugins"></a> [cluster\_plugins](#input\_cluster\_plugins) | A set of Elasticsearch plugins to install | `set(string)` | `null` | no |
| <a name="input_cluster_security_group_ids"></a> [cluster\_security\_group\_ids](#input\_cluster\_security\_group\_ids) | List of security group IDs to be assigned to cluster | `list(string)` | `[]` | no |
| <a name="input_cluster_service_account_id"></a> [cluster\_service\_account\_id](#input\_cluster\_service\_account\_id) | ID of the service account authorized for this cluster | `string` | `null` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version of the Elasticsearch cluster | `string` | `null` | no |
| <a name="input_cluster_vpc_id"></a> [cluster\_vpc\_id](#input\_cluster\_vpc\_id) | ID of the network, to which the Elasticsearch cluster belongs | `string` | n/a | yes |
| <a name="input_data_hosts"></a> [data\_hosts](#input\_data\_hosts) | A list of DATA hosts.<br>  Example:<pre>data_hosts = [<br>    {<br>      name      = "dnode1"<br>      zone      = "ru-central1-a"<br>      subnet_id = "dfsdfdfsfsd343434"<br>    },<br>    {<br>      name      = "dnode2"<br>      zone      = "ru-central1-b"<br>      subnet_id = "1fs567hfsd343434"<br>    }<br>  ]</pre> | `any` | n/a | yes |
| <a name="input_data_node_resources"></a> [data\_node\_resources](#input\_data\_node\_resources) | Resources allocated to hosts of the Elasticsearch data nodes subcluster | <pre>object({<br>    resource_preset_id = string<br>    disk_type_id       = string<br>    disk_size          = number<br>  })</pre> | n/a | yes |
| <a name="input_internal_dns_zone_id"></a> [internal\_dns\_zone\_id](#input\_internal\_dns\_zone\_id) | Internal DNS zone ID for Elasticsearch hosts | `string` | `null` | no |
| <a name="input_internal_dns_zone_name"></a> [internal\_dns\_zone\_name](#input\_internal\_dns\_zone\_name) | Internal DNS zone name for Elasticsearch hosts | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Kubernetes cluster resources | `map(any)` | `{}` | no |
| <a name="input_master_hosts"></a> [master\_hosts](#input\_master\_hosts) | A list of MASTER hosts.<br>  Example:<pre>master_hosts = [<br>    {<br>      name      = "mnode1"<br>      zone      = "ru-central1-a"<br>      subnet_id = "dfsdfdfsfsd343434"<br>    },<br>    {<br>      name      = "mnode2"<br>      zone      = "ru-central1-b"<br>      subnet_id = "1fs567hfsd343434"<br>    }<br>  ]</pre> | `any` | `[]` | no |
| <a name="input_master_node_resources"></a> [master\_node\_resources](#input\_master\_node\_resources) | Resources allocated to hosts of the Elasticsearch master nodes subcluster | <pre>object({<br>    resource_preset_id = string<br>    disk_type_id       = string<br>    disk_size          = number<br>  })</pre> | <pre>{<br>  "disk_size": 10,<br>  "disk_type_id": "network-ssd",<br>  "resource_preset_id": "s2.micro"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_cname_data_hosts"></a> [cluster\_cname\_data\_hosts](#output\_cluster\_cname\_data\_hosts) | A list of Elasticsearch CNAME DATA hosts |
| <a name="output_cluster_cname_master_hosts"></a> [cluster\_cname\_master\_hosts](#output\_cluster\_cname\_master\_hosts) | A list of Elasticsearch CNAME MASTER hosts |
| <a name="output_cluster_data_hosts"></a> [cluster\_data\_hosts](#output\_cluster\_data\_hosts) | A list of Elasticsearch DATA hosts |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Elasticsearch cluster ID |
| <a name="output_cluster_master_hosts"></a> [cluster\_master\_hosts](#output\_cluster\_master\_hosts) | A list of Elasticsearch MASTER hosts |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Elasticsearch cluster name |
| <a name="output_cluster_service_account_id"></a> [cluster\_service\_account\_id](#output\_cluster\_service\_account\_id) | Elasticsearch cluster service account ID |
<!-- END_TF_DOCS -->
