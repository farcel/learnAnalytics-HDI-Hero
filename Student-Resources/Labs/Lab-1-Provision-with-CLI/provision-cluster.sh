#!/usr/bin/env bash
#description     :This script provisions an HDInsight cluster
#author          :Ali Zaidi (github: akzaidi; contact alizaidi at microsoft dot com)
#date            :2017-08-24
#version         :0.1
#notes           :Requires azure CLI, and you must login prior to usage, azure login.
#====================================================================================

# set resource manager mode

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