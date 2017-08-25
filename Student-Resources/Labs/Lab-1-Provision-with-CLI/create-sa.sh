#!/usr/bin/env bash
#description     :This script creates a storage account and prints keys
#author          :Ali Zaidi (github: akzaidi; contact alizaidi at microsoft dot com)
#date            :2017-08-24
#version         :0.1
#notes           :Requires azure CLI, and you must login prior to usage, azure login.
#====================================================================================

# set resource manager mode

azure config mode arm

# parameters for storage account

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

