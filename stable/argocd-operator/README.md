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
| operator.affinity | object | `{}` | A more expressive way to constrain ArgoCD controller Pods to specific nodes |
| operator.extraEnv | list | `[]` | A list of environment objects used to inject additional environment variables into the controller pod |
| operator.image | object | `{"pullPolicy":"IfNotPresent","repository":"quay.io/argoprojlabs/argocd-operator","tag":"v0.4.0"}` | Configures the image to use for the argocd-operator pod(s) |
| operator.imagePullSecrets | list | `[]` | One or many secret(s), that store Docker credentials that are used for accessing a private image registry |
| operator.nodeSelector | object | `{}` | Constrain ArgoCD controller Pods to be scheduled to nodes with specific labels |
| operator.nsClusterConfig | string | `""` | List of namespaces of cluster-scoped Argo CD instances |
| operator.nsToWatch | string | `"argo-cd-system"` | Defines which namespace for the operator to watch for deployment of related argocd components |
| operator.podAnnotations | object | `{}` | Annotations to apply to the argocd controller pods that are deployed as part of this release |
| operator.podLabels | object | `{}` | Labels to apply to the argocd controller pods that are deployed as part of this release |
| operator.replicaCount | int | `1` | The number of replicas of the ArgoCD controller |
| operator.resources | object | `{"requests":{"cpu":"200m","ephemeral-storage":"500Mi","memory":"256Mi"}}` | Resource requests and limits to define the allowed compute and storage for each deployment |
| operator.securityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | Defines privilege and access control settings for the ArgoCD controller Pod or Container |
| operator.tolerations | list | `[]` | A list of node taints that this deployment should tolerate |

