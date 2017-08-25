# Manage Hadoop clusters using Azure CLI - Azure HDInsight

## Links

+ [Manage HDInsight Clusters with Azure CLI](https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-administer-use-command-line)
+ [Create HDInsight Clusters using the Azure CLI](https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-hadoop-create-linux-clusters-azure-cli)

The Azure-CLI is a Node.js utility for managing Azure resources using a command-line interface. 

**Note** - there is a new cli-utility written in Python, [azure-cli 2.0](https://github.com/Azure/azure-cli), but it does not yet support provisioning HDInsight clusters. 

### Create a New Resource Group and Storage Account

We'll first create a new resource group and storage account for our cluster. Take a look at the script: `create-sa.sh`.

```{include=create-sa.sh}
```

This script will create a resource group and a storage account for you, and print out the key for the storage account. Keep note of the key.

### Provision Cluster

Pass the key from the previous script as the first argument to the script `provision-cluster.sh`, i.e., `./provision-cluster.sh $KEY`

```{include=provision-cluster.sh}
```

You should now have a brand new cluster!