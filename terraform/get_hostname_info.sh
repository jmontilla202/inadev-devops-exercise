#!/bin/bash

export JENKINS_LB="Jenkins: http://$(kubectl get service -n jenkins jenkins -o jsonpath='{.status.loadBalancer.ingress[].hostname}'):8080"
export WAPI_LB="Wapi: http://$(kubectl get service -n wapi wapi -o jsonpath='{.status.loadBalancer.ingress[].hostname}')/forecast"

echo $JENKINS_LB
echo $WAPI_LB