#! /bin/bash

set -xe

helm install --wait age ../helm/age --set image.repository=age --set image.tag=latest --set image.pullPolicy=Never

kubectl get po,svc

kubectl apply -f k8s-component-test-job.yaml

kubectl wait --for=condition=complete --timeout=1m job/component-test

kubectl logs -l type=component-test

SUCCESS=$(kubectl get job component-test -o jsonpath='{.status.succeeded}')

if [ $SUCCESS != '1' ]; then exit 1; fi

echo "Component test succesful"
