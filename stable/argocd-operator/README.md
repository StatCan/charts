# argocd-operator

![Version: 0.5.0](https://img.shields.io/badge/Version-0.5.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.4.0](https://img.shields.io/badge/AppVersion-v0.4.0-informational?style=flat-square)

A Helm chart that deploys ArgoCD Operator. The ArgoCD Operator manages ArgoCD installation and components

**Homepage:** <https://argocd-operator.readthedocs.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| sylus | <william.hearn@canada.ca> |  |
| zachomedia | <zachary.seguin@canada.ca> |  |

## Source Code

* <https://github.com/argoproj-labs/argocd-operator>

## Prerequisites

- Kubernetes 1.20+
- Helm v3.7.0+

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| operator.affinity | object | `{}` |  |
| operator.clusterDomain | string | `""` |  |
| operator.image.pullPolicy | string | `"IfNotPresent"` |  |
| operator.image.repository | string | `"quay.io/argoprojlabs/argocd-operator"` |  |
| operator.image.tag | string | `"v0.4.0"` |  |
| operator.imagePullSecrets | list | `[]` |  |
| operator.nodeSelector | object | `{}` |  |
| operator.nsClusterConfig | string | `""` |  |
| operator.nsToWatch | string | `"argo-cd-system"` |  |
| operator.podAnnotations | object | `{}` |  |
| operator.podLabels | object | `{}` |  |
| operator.replicaCount | int | `1` |  |
| operator.resources.requests.cpu | string | `"200m"` |  |
| operator.resources.requests.ephemeral-storage | string | `"500Mi"` |  |
| operator.resources.requests.memory | string | `"256Mi"` |  |
| operator.securityContext.fsGroup | int | `1000` |  |
| operator.securityContext.runAsGroup | int | `1000` |  |
| operator.securityContext.runAsNonRoot | bool | `true` |  |
| operator.securityContext.runAsUser | int | `1000` |  |
| operator.tolerations | list | `[]` |  |

