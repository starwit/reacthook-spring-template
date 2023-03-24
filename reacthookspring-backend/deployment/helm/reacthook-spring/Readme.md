Example customValues.yaml

```yaml
ingress:
  enabled: true
  hosts:
    - host: <HOSTNAME>
      paths: 
        - /reacthookspring
  tls: 
   - secretName: <TLS-SECRET>
     hosts:
       - <HOSTNAME>

mariadb:
  image:
    registry: <CUSTOM-REGISTRY-IF-NEEDED>
    pullSecrets: 
      - <PULL-SECRETS-FOR-THE-CUSTOM-REGISTRY>
  auth:
    rootPassword: root #change
    database: reacthookspring #change
    username: reacthookspring #change
    password: reacthookspring #change

github:
  registry:
    username: <GITHUB-USERNAME>
    pat: <GENERATED-IN-GITHUB> #you only need to be able to read packages 
```