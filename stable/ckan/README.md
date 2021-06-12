Helm Chart for CKAN
===================

> NOTE: This chart was extended from https://github.com/keitaroinc/ckan-helm with modifications to support the Open Knowledge version of CKAN.

A Helm chart for CKAN.

This chart deploys a self contained CKAN instance with all of its dependencies. These can be enabled/disabled if they already exist in your infrastructure.

Two jobs for initializing Postgres and SOLR can also be enabled through the values. These will use the provided CKAN environment to set the access permissions for the ckan and datastore DB users as well as create a SOLR collection for the CKAN instance.

## Prerequisites

* Kubernetes 1.9+
* Install [Helm](https://github.com/helm/helm/releases)
