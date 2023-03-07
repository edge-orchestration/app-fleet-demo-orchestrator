set -o xtrace
CLUSTER1_LABELS="--set-string labels.country=france --set-string labels.region=grenoble --set-string labels.industry=manufacturing --set-string labels.provider=microk8s --set-string labels.customer=customer1  --set-string labels.device=thinkedge"
helm --kube-context microk8s -n cattle-fleet-system install --create-namespace --wait \
    ${CLUSTER1_LABELS} \
    --values values.yaml \
    --debug fleet-agent https://github.com/rancher/fleet/releases/download/v0.6.0-rc.4/fleet-agent-0.6.0-rc.4.tgz

export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac)
export OS=$(uname | awk '{print tolower($0)}')    

export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/v1.27.0
curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH}

gpg --keyserver keyserver.ubuntu.com --recv-keys 052996E2A20B5C7E
curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt
curl -LO ${OPERATOR_SDK_DL_URL}/checksums.txt.asc
gpg -u "Operator SDK (release) <cncf-operator-sdk@cncf.io>" --verify checksums.txt.asc
grep operator-sdk_${OS}_${ARCH} checksums.txt | sha256sum -c -

chmod +x operator-sdk_${OS}_${ARCH} && sudo mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk

operator-sdk olm install 

#NAME                                            NAMESPACE    KIND                        STATUS
#catalogsources.operators.coreos.com                          CustomResourceDefinition    Installed
#clusterserviceversions.operators.coreos.com                  CustomResourceDefinition    Installed
#installplans.operators.coreos.com                            CustomResourceDefinition    Installed
#olmconfigs.operators.coreos.com                              CustomResourceDefinition    Installed
#operatorconditions.operators.coreos.com                      CustomResourceDefinition    Installed
#operatorgroups.operators.coreos.com                          CustomResourceDefinition    Installed
#operators.operators.coreos.com                               CustomResourceDefinition    Installed
#subscriptions.operators.coreos.com                           CustomResourceDefinition    Installed
#olm                                                          Namespace                   Installed
#operators                                                    Namespace                   Installed
#olm-operator-serviceaccount                     olm          ServiceAccount              Installed
#system:controller:operator-lifecycle-manager                 ClusterRole                 Installed
#olm-operator-binding-olm                                     ClusterRoleBinding          Installed
#cluster                                                      OLMConfig                   Installed
#olm-operator                                    olm          Deployment                  Installed
#catalog-operator                                olm          Deployment                  Installed
#aggregate-olm-edit                                           ClusterRole                 Installed
#aggregate-olm-view                                           ClusterRole                 Installed
#global-operators                                operators    OperatorGroup               Installed
#olm-operators                                   olm          OperatorGroup               Installed
#packageserver                                   olm          ClusterServiceVersion       Installed
#operatorhubio-catalog                           olm          CatalogSource               Installed