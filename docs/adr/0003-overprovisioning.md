# 3. Overprovisioning

Date: 2020-10-28


## Status

Accepted


## Context

ICAP processing workloads are created on-demand as new Pods, one for each document to be rebuilt.
This leads to fluctuating need for compute resources and, in turn, nodes.

Anecdotal evidence suggests that Azure's scale sets can be sluggish to respond to scale up requests, leading
to potentially long periods of time during which Pods remain `Unschedulable`.


## Decision

In order to compensate for this expected sluggishness to some extent, we will add overprovisioning ballast to each
cluster.
We will add a new Kubernetes PriorityClass named `ballast` with a priority of -10000.
We will add a helm chart which will schedule a configurable number of Pods using this priority class.
Each Pod will request a configurable amount of CPU and memory.
Thanks to the unfavourable PriorityClass, these Pods should be preempted if cluster resources become contested.
This will trigger scale-up early, hopefully compensating for the time needed to bring new nodes online.


## Consequences

We accept that by over-provisioning compute resources, the operating cost will be higher.
