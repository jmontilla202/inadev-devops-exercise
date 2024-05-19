#!/bin/bash

kubectl get service -n wapi wapi -o jsonpath='{.status.loadBalancer.ingress[]}'

