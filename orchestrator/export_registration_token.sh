kubectl --namespace edge-clusters get secret edge-clusters-registration-token -o 'jsonpath={.data.values}' | base64 --decode > values.yaml
