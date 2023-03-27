# Background
Trino (https://trino.io/) is an open source project built to be a "Fast distributed SQL query engine for big data analytics”, it is a fork of the Presto project – which has proven reliability processing large production workloads.

As a component of AAW, Trino allows users to run distributed SQL queries over heterogeneous data sources at scale. This provides a number of benefits to users and to the AAW platform, including:
•	Data does not need to be copied to the AAW platform, reducing storage costs, complexity and security concerns.
•	Access control to these data sources can be centralized, fine grained and automated.
•	Users spend less time managing their data and more time performing their analysis
•	Different data sources and types can be combined in the same query
•	A variety of visualization / BI tools can use Trino as the interface to data sources instead of giving them direct access

## Data sources
The standard implementation of Trino will apply to all user namespaces when they are created and connect to the default unclassified & protected-b AAW Azure blob storage containers which are used by the Minio storage solution. The existing Kubeflow profiles controller will configure these containers and default permissions for each namespace.

The advanced use case for users with custom requirements will utilize Fair Data Infrastructure (FDI) infrastructure to map their own storage containers, permissions for these containers will be provided by the FDI API and they will be contained in unique trino catalogs to isolate them from other users.

Trino uses a connector system to access different types of data, the AAW implementation is using a Hive connector (from the Apache Hive project which is used primarily within Hadoop clusters). The Hive component uses a metadata storage mechanism to index and organize available data sources.
•	The Hive connector is used to create a Catalog which corresponds to an Azure storage account (or an individual managed database)
•	Within the Catalog a Schema is used to identify individual azure storage account Containers (or the equivalent database schema type)
•	User data access is granted at the Schema/Container level
•	Tables are accessed by users within the Schemas
o	Hive supports data in Text, CRV and JSON formats, but is recommended that users convert their data to ORC or Parquet formats for better performance

## Access and Authentication
Users can access the trino system from their notebooks using various methods. The primary supported method is the Trino client CLI, which is installed and configured in their notebook image by default. Another user friendly mechinism is to use a Trino python library, which is a simple way to intergrate Trino data into user workloads.

Users can use Oauth2.0 authentication at this time. Trino authentication is done at the Azure Active Directory level, all users will be required to login.

# Architecture

The AAW-Trino implementation will consist of the following kubernetes components in the AAW clusters:
•	trino-system namespace
o	A coordinator pod that will receive requests from users and perform Authentication, Authorization and distribution of requests to worker nodes.
	The coordinator also offers a Web-UI for users to be able to view the history and status of their queries, but not the results
o	A scalable number of worker pods which will execute the requests sent from the coordinator pod and forward the results directly to the user.
•	trino-b-system namespace
o	A separate trino-b-system namespace will contain a mirror of the trino-system components, these components will handle protected-b storage accounts
	The trino-b-system services will be isolated by Kubernetes network policies to ensure that only pods which are certified for protected-b data can access them
	The trino-b-system will have read-only access to unclassified storage accounts, protected-b pods will not have access to the regular trino-system (using additional network policies)
•	hive-system namespace
o	A metadata pod which indexes all of the available data sources and related metatadata (owner, location, type, size, column names etc.)
	The metadata pod is backed by an Azure managed postgres database
•	daaas-system namespace
o	Existing namespace/profile controller modified to add authorization rules to trino-system secret configuration (json format) on creation of namespace, granting access to azure storage buckets to namespace owner and contributors
	Rules for protected-b storage provided by existing FDI api used by blob-csi and includes option for read-only storage permissions
•	user namespace
o	Trino client added to existing user images (kubeflow, rstudio, remote desktop)
	Configured to inject credentials automatically from the namespaces secrets on execution of Trino client

![Trino system overview](docs/trino_overview.png?raw=true "Trino overview")

# Supported file types

The following file types are supported for the Hive connector:

- ORC
- Parquet
- Avro
- RCText (RCFile using ColumnarSerDe)
- RCBinary (RCFile using LazyBinaryColumnarSerDe)
- SequenceFile
- JSON (using org.apache.hive.hcatalog.data.JsonSerDe)
- CSV (using org.apache.hadoop.hive.serde2.OpenCSVSerde)
- TextFile

More info: https://trino.io/docs/current/connector/hive.html

# Usage examples

## Converting data files

### SAS to CSV

```
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq
from sas7bdat import SAS7BDAT

# convert SAS7BDAT to CSV (not recommended)
with SAS7BDAT('sas_dataset.sas7bdat', skip_header=False) as reader:
    df= reader.to_data_frame();
    df.info(verbose=True)
    reader.convert_file('convert_sas_to_csv.csv', delimiter=',')
```
### SAS to Parquet
```
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq
from sas7bdat import SAS7BDAT

# convert SAS7BDAT to Parquet (recommended)
with SAS7BDAT('sas_dataset.sas7bdat', skip_header=False) as reader:
    df= reader.to_data_frame();
    df_table = pa.Table.from_pandas(df);
    pq.write_table(df_table, 'convert_sas_to_parquet.parquet', compression='SNAPPY')
    df_parquet = pd.read_parquet('convert_sas_to_parquet.parquet')
df_table
```

## Trinio client basic usage example (from Juypter notebook)

> Trino server address and user credentials are automatically injected, catalog and schema may be set by default also but can be changed
```shell
jovyan@jupyter-pat-0:~$ trino --version
Trino CLI 377

jovyan@jupyter-pat-0:~$ trino --user 'pat.ledgerwood@cloud.statcan.ca'
trino>

trino> show catalogs;
  Catalog
------------
 unclassified
 system
 tpcds
 tpch
 ...

trino> show schemas from unclassified;
       Schema
--------------------
 patledgerwood
...

trino> use unclassified.patledgerwood;
USE

trino:patledgerwood> show tables;
 Table
--------
 private_test
...

trino:patledgerwood> CREATE TABLE private_test_new2 (id varchar, name varchar) WITH (format='CSV');
CREATE TABLE

trino:patledgerwood> show tables;
 Table
--------
 private_test
 private_test_new
...

trino:patledgerwood> describe private_test;
  Column   |    Type     | Extra | Comment
-----------+-------------+-------+---------
 id        | varchar |       |
 name      | varchar |       |
...

trino:patledgerwood> insert into private_test_new values ('1', 'test');
INSERT: 1 row
...

trino:patledgerwood> select * from private_test_new;
 id | name
----+------
 1  | test
(1 rows)
```

## Python basic usage example (from Juypter notebook)
```shell
pip config set global.index-url 'https://jfrog.aaw.cloud.statcan.ca/artifactory/api/pypi/pypi-remote/simple'
pip install trino
```

```python
import os
from trino.dbapi import connect
from trino.auth import OAuth2Authentication

conn = connect(
    host="trino.aaw-dev.cloud.statcan.ca",
    http_scheme="https",
    port="443",
    user="pat.ledgerwood@cloud.statcan.ca",
    auth=OAuth2Authentication(),
    catalog="unclassified",
    schema="patledgerwood",
)

cur = conn.cursor()
cur.execute("SELECT * FROM private_test_new")
rows = cur.fetchall()

print(rows)
[['1', 'test']]
```
