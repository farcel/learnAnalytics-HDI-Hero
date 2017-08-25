# Submitting Script Actions Using Azure CLI

## Links

+ [Customize Linux-based HDInsight clusters using Script Actions](https://docs.microsoft.com/en-us/azure/hdinsight/hdinsight-hadoop-customize-cluster-linux#apply-a-script-action-to-a-running-cluster)

### Submit a Script Action Using Azure CLI

You can submit script actions to cluster during provisioning. We can also submit script actions to already running clusters usign Azure CLI. A script action is a bash script that is run on one or more of your nodes, allowing you to configure or install additional components. 

The command to submit a script action using Azure CLI to a running cluster is simple:

```bash
 azure hdinsight script-action create \
 	<clustername> -g <resourcegroupname> \
 	-n <scriptname> -u <scriptURI> -t <nodetypes>
```

Valid node types are `headnode`, `workernode`, and `zookeeper`. If the script should be applied to multiple node types, specify the types separated by a ';'. For example,` -n headnode;workernode`.

We have configured this into the script `submit-script-action.sh` with three required parameters: script name, script URI, and nodetypes. Let's run the script to configure OMS integration on our cluster.

```bash
./submit-script-action.sh sparkoms https://raw.githubusercontent.com/hdinsight/HDInsightOMS/master/monitoring/scriptspark.sh headnode:workernode
```

