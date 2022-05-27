Helm Chart: Fluentd Operator
================

Base on : https://github.com/vmware/kube-fluentd-operator





## Changes made to values.yaml 

Change from false to true. I.e. access denied for everything.

```yaml
rbac:
  create: true
```
