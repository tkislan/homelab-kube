# Setup

```
ssh-keygen -t ed25519 -f flux_gh_deploykey
```

```
flux bootstrap git \
  --url=ssh://git@github.com/tkislan/homelab-kube \
  --branch=main \
  --private-key-file=flux_gh_deploykey \
  --path=secrets
```

```
flux install

flux create source git infra \
    --url=ssh://git@github.com/tkislan/homelab-kube \
    --branch=main \
    --private-key-file=flux_gh_deploykey


 flux create kustomization secrets \
    --namespace=flux-system \
    --source=GitRepository/infra \
    --path="./secrets" \
    --prune=true \
    --interval=5m


  flux create kustomization infra \
    --namespace=flux-system \
    --depends-on=secrets \
    --source=GitRepository/infra \
    --path="./infra" \
    --prune=true \
    --interval=5m

  flux create kustomization apps \
    --namespace=flux-system \
    --depends-on=infra \
    --source=GitRepository/infra \
    --path="./apps" \
    --prune=true \
    --interval=5m
```


```
flux reconcile source git infra && flux reconcile kustomization secrets && flux reconcile kustomization infra && flux reconcile kustomization apps
```


TODO - add `nohup`
```
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055
```

```
tailscale up --auth-key=<key>
```

### Debug Renovate config matchers
```
docker run --rm -it -v $PWD:/usr/src/app -e LOG_LEVEL=debug ghcr.io/renovatebot/renovate --platform=local > renovate.log
```
