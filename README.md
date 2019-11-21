# Build node exporter image

```
cd packer
packer build node-exporter.json
```

# Build prometheus server image

```
cd packer
packer build prometheus-server.jso
```

# Deploy infrastructure

```
terraform plan -var="node-exporter-image-id=IMAGE_ID_FROM_PACKER" -var="prometheus-server-image-id=IMAGE_ID_FROM_PACKER" -var='whitelist-ips=["WHITELIST_IP_1/32","WHITELIST_IP_2/32"]'
```
