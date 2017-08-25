#!/usr/bin/env bash
#description     :This script submits a script action to an HDInsight cluster
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

clust="clust"
CNAME=${1:-$RG$clust}

SCRIPTNAME=$1

SCRIPTURI=$2

$NODETYPES=$3

printf "Submitting script action to cluster %s" "$CNAME"

 azure hdinsight script-action create \
 	$CNAME -g $RG \
 	-n $SCRIPTNAME -u $SCRIPTURI -t $NODETYPES

