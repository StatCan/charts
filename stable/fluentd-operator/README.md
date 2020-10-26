Helm Chart: Fluentd Operator
================

Base on : https://github.com/vmware/kube-fluentd-operator



## Changes made to values.yaml 

Change from false to true. I.e. access denied for everything.

```yaml
rbac:
  create: true
```



Change image tag from latest to v1.11.0-3-ge92efff and repository

```yaml
image:
  #repository: jvassev/kube-fluentd-operator
  repository: artifactory.cloud.statcan.ca/docker/jvassev/kube-fluentd-operator
  pullPolicy: IfNotPresent
  #tag: latest
  tag: v1.11.0-3-ge92efff
```



Comment out adminNamespace. Fluentd operator will not process logs from kube-system namespace.

```yaml
 #adminNamespace: "kube-system"
```



## Changes to daemonset.yaml

Removed those lines of code: 



```yaml
{{- if .Values.adminNamespace }}
- --admin-namespace={{ .Values.adminNamespace }}
{{- end }}
```

 