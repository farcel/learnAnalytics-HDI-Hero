# Manage Hadoop clusters using Azure CLI - Azure HDInsight

## Links

+ [Manage HDInsight Clusters with Azure CLI](https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-administer-use-command-line)
+ [Create HDInsight Clusters using the Azure CLI](https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-hadoop-create-linux-clusters-azure-cli)

The Azure-CLI is a Node.js utility for managing Azure resources using a command-line interface. 

**Note** - there is a new cli-utility written in Python, [azure-cli 2.0](https://github.com/Azure/azure-cli), but it does not yet support provisioning HDInsight clusters. 

### Create a New Resource Group and Storage Account

We'll first create a new resource group and storage account for our cluster. Take a look at the script: `create-sa.sh`.

```bash
yourname=$(whoami)
class="hdiclass"

ARG1=${1:-$yourname$class}
RG=$ARG1

ARG2=${2:-centralus}
LOC=$ARG2

sa="sa"
ARG3=${3:-$yourname$sa}
SA=$ARG3

# create resource group
printf "Creating resource group %s in region %s" "$RG" "$LOC"

azure group create $RG $LOC

# create storage account
printf "Creating storage account %s" "$SA"

azure storage account create -g \
	$RG --sku-name RAGRS -l $LOC \
	--kind Storage $SA

# print keys
azure storage account keys list -g $RG $SA
```

This script will create a resource group and a storage account for you, and print out the key for the storage account. Keep note of the key.

### Provision Cluster

Pass the key from the previous script as the first argument to the script `provision-cluster.sh`, i.e., `./provision-cluster.sh $KEY`

```bash
azure config mode arm

yourname=$(whoami)
class="hdiclass"

ARG1=$yourname$class
RG=$ARG1

ARG2="centralus"
LOC=$ARG2

sa="sa"
ARG3=$yourname$sa
blob=".blob.core.windows.net"
SA=$ARG3$blob

CTYPE="spark"

SKEY="$1"

PASS=${2:-"PassHDI123!"}

clust="clust"
CNAME=${3:-$RG$clust}

printf "Creating cluster named %s in resource group %s" "$CNAME" "$RG"

azure hdinsight cluster create -g $RG \
	-l $LOC -y Linux --clusterType $CTYPE \
	--defaultStorageAccountName $SA \
	--defaultStorageAccountKey $SKEY --defaultStorageContainer \
	clustername --workerNodeCount 2 --userName admin --password \
	$PASS --sshUserName sshuser \
	--sshPassword $PASS $CNAME
```

You should now have a brand new cluster!