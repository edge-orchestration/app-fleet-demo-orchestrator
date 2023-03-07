set -o xtrace
CLUSTER2_LABELS="--set-string labels.country=france --set-string labels.region=paris --set-string labels.industry=manufacturing --set-string labels.provider=microk8s --set-string labels.customer=customer1 --set-string labels.device=bullsequana"
helm --kube-context microk8s -n cattle-fleet-system install --create-namespace --wait \
    ${CLUSTER2_LABELS} \
    --values values.yaml \
    --debug fleet-agent https://github.com/rancher/fleet/releases/download/v0.6.0-rc.4/fleet-agent-0.6.0-rc.4.tgz