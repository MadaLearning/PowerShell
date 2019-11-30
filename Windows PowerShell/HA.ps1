#FailoverClusters#

#Create Cluster

new-cluster -name cluster1 -node server1,server2

new-cluster -name cluster1 -node server1,server2 -staticaddress 10.10.1.120

=================================================================================
# Configure the Quorum

#To configure the quorum to use a node majority, with no witness:

set-clusterquorum -cluster cluster1 -nodemajority

#To configure the quorum with votes from each node and a disk witness:

set-clusterquorum -cluster cluster1 -nodeanddiskmajority "cluster disk 1"

#To configure a cluster node to not have a quorum vote:

(get-clusternode clusternode1).nodeweight=0

(get-clusternetwork "network1").role =1

#The values for the Role property are as follows:
#0 Disabled for cluster communication
#1 Enabled for cluster communication only
#3 Enabled for client and cluster communication

=====================================================================================
#Restore single node or cluster configuration

wbadmin get versions

wbadmin get items -version: 11/14/2016:05:09

wbadmin start recovery -itemtype:app -items:cluster -version:01/01/2008-00:00

=======================================================================================

Get-Cluster -Name Cluster-HyperV | Select ClusterFunctionalLevel

Update-ClusterFunctionalLevel –Cluster cluster-hyperv.contoso.com –Force