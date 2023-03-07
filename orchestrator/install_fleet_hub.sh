kubectl config view -o json --raw  | jq -r '.clusters[] | select(.name=="microk8s-cluster").cluster["certificate-authority-data"]' | base64 -d > ca.pem
export API_SERVER_URL="https://management.edge-clusters.net:16443"
export API_SERVER_CA="ca.pem"
helm --kube-context microk8s -n cattle-fleet-system install --create-namespace --wait \
    fleet-crd https://github.com/rancher/fleet/releases/download/v0.6.0-rc.4/fleet-crd-0.6.0-rc.4.tgz
helm --kube-context microk8s -n cattle-fleet-system install --create-namespace --wait \
    --set apiServerURL="${API_SERVER_URL}" \
    --set-file apiServerCA="${API_SERVER_CA}" \
    fleet https://github.com/rancher/fleet/releases/download/v0.6.0-rc.4/fleet-0.6.0-rc.4.tgz
