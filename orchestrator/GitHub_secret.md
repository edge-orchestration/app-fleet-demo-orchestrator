# How to use GitHub PAT in Kubernetes to pull from ghcr.io?

1. Create a Personal Acces Token PAT in GitHub with only packages:read scope

2. Apply it as a secret of type docker-registry

```bash
kubectl create secret docker-registry dockerconfigjson-github-com --docker-server=https://ghcr.io --docker-username=mygithubusername --docker-password=mygithubreadtoken --docker-email=mygithubemail
```

3. Use it later on schedule pods requiring images from ghcr.io

Example:

```yml
apiVersion: v1
kind: Pod
metadata:
  name: name
spec:
  containers:
    - name: name
      image: ghcr.io/username/imagename:label
      imagePullPolicy: Always
  imagePullSecrets:
    - name: dockerconfigjson-github-com
```
