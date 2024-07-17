# cidr-allocator

![Version: 1.0.2](https://img.shields.io/badge/Version-1.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.4.2](https://img.shields.io/badge/AppVersion-v0.4.2-informational?style=flat-square)

A Helm chart to deploy the STATCAN CIDR-Allocator Controller and CRDs to a Kubernetes Cluster

**Homepage:** <https://statcan.gc.ca>

## Requirements

Kubernetes: `>= 1.16.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | any particular affinities to apply to the created deployment |
| envVars | list | `[]` | any additional environment vars to pass to container (manager) |
| fullnameOverride | string | `""` | override full name |
| image.pullPolicy | string | `"IfNotPresent"` | can be one of "Always", "IfNotPresent", "Never" |
| image.repository | string | `"statcan/cidr-allocator"` | the source image repository |
| image.tag | string | `"v0.4.1"` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | specifies credentials for a private registry to pull source image |
| nameOverride | string | `""` | override name |
| nodeSelector | object | `{}` | node selector to apply to scheduling of pods |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| priorityClassName | string | `""` |  |
| prometheus | object | `{"enabled":false,"interval":"60s","path":"/metrics","port":9003,"scheme":"https","scrapeTimeout":"30s"}` | specifies configuration for prometheus integration |
| prometheus.enabled | bool | `false` | specifies whether to enable prometheus metrics export via a ServiceMonitor |
| prometheus.interval | string | `"60s"` | Scrape interval. If not set, the Prometheus default scrape interval is used. |
| prometheus.path | string | `"/metrics"` | path used to get metrics from operator |
| prometheus.port | int | `9003` | used for both port and target for metrics-related services |
| prometheus.scheme | string | `"https"` | the metrics endpoint scheme |
| prometheus.scrapeTimeout | string | `"30s"` | the metrics scaping timeout |
| rbac.create | bool | `true` | Specifies whether RBAC resources should be created (recommended) |
| replicaCount | int | `1` | number of replicas to create for the controller |
| resources | object | `{}` | resource limits/requests for created resources |
| securityContext | object | `{"runAsNonRoot":true}` | the pod security context which defines privilege and access control settings for the controller Pod |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[{"operator":"Exists"}]` | a list of node tolerations to apply to the deployment |
| webhooksEnabled | bool | `false` | if not set, will be 'false' |
