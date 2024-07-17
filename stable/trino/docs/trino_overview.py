import os
import time

from diagrams import Cluster, Diagram, Edge
from diagrams.k8s.compute import Deployment, Pod, StatefulSet
from diagrams.k8s.network import NetworkPolicy, Service
from diagrams.k8s.podconfig import Secret
from diagrams.k8s.rbac import User
from diagrams.k8s.storage import PersistentVolume, PersistentVolumeClaim
from diagrams.azure.storage import BlobStorage, DataLakeStorage
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.iac import Terraform
from diagrams.onprem.gitops import Argocd

def myself() -> str:
    f = os.path.basename(__file__)
    no_ext = ".".join(f.split(".")[:-1])
    return no_ext

with Diagram(myself(), show=False, direction="LR"):

    admin = User("aaw-admin")
    newns = User("aaw-portal")
    
    # cicd = Terraform("CICD provisioning")
    # argocd = Argocd("argocd-operator")

    with Cluster("Azure Managed Services"):
        with Cluster("Storage Accounts"):
            unclassified =  BlobStorage("unclassified-aaw-azure-blob")
            protb =    BlobStorage("protected-b-aaw-azure-blob")
            custom = DataLakeStorage("project-custom-adls2")

        with Cluster("Databases"):
            metastoredb = PostgreSQL("aawhive-metastore")
            metastoredbb = PostgreSQL("aawhive-metastore-b")

    with Cluster("AAW Cluster"):

        with Cluster("user-namespace"):
            user = Pod("notebook")

        with Cluster("trino-b-system"):
            trinob = Pod("trino-coordinator")
            workersb = [
                Pod("trino-worker-0"),
                Pod("trino-worker-X")]

            workersb >> user
            trinob >> Edge(style="dotted") << workersb
            user >> Edge(style="solid") << trinob

            trinob >> Edge(style="dotted", color="green", label="read-only") << unclassified
            trinob >> Edge(style="dotted", color="green") << protb
            trinob >> Edge(style="dotted", color="green") << custom

            workersb >> Edge(style="dotted", color="green", label="read-only") << unclassified
            workersb >> Edge(style="dotted", color="green") << protb
            workersb >> Edge(style="dotted", color="green") << custom

        with Cluster("trino-system"):
            trino = Pod("trino-coordinator")
            workers = [
                Pod("trino-worker-0"),
                Pod("trino-worker-X")]

            workers >> user
            trino >> Edge(style="dotted") << workers
            user >> Edge(style="solid") >> trino
            trino >> Edge(style="dotted", color="blue") << unclassified
            trino >> Edge(style="dotted", color="blue") << custom

            workers >> Edge(style="dotted", color="blue") << unclassified
            workers >> Edge(style="dotted", color="blue") << custom

        with Cluster("daaas-system"):
            controller = Pod("ns-controller")

        newns >> controller
        controller >> Edge(style="dotted") >> trino
        controller >> Edge(style="dotted") >> trinob
        admin >> Edge(style="dotted") >> trino
        admin >> Edge(style="dotted") >> trinob

        with Cluster("hive System"):
            hive = Pod("hive-metastore")

            trino >> Edge(style="solid", color="blue") << hive
            trinob >> Edge(style="solid", color="blue") << hive

            hive >> Edge(style="dash", color="orange") << metastoredb
            hive >> Edge(style="dash", color="orange") << metastoredbb

            hive >> Edge(style="dotted", color="orange") << unclassified
            hive >> Edge(style="dotted", color="orange") << protb
            hive >> Edge(style="dotted", color="orange") << custom
        
        
        
        