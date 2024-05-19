#!/bin/bash

kubectl get service -n jenkins jenkins -o jsonpath='{.status.loadBalancer.ingress[]}'