FROM debian:13.1-slim

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history && mkdir -p /commandhistory"\
    && echo "$SNIPPET" >> "/root/.bashrc"

RUN apt-get update && apt-get install -y curl vim git bash-completion procps openvpn

RUN echo "source /usr/share/bash-completion/bash_completion" >> /root/.bashrc

RUN rm -rf /tmp/kubectl && mkdir /tmp/kubectl && (cd /tmp/kubectl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.30.0/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client) && \
    rm -rf /tmp/kubectl

RUN rm -rf /tmp/helm && mkdir /tmp/helm && (cd /tmp/helm && \
    curl -LO https://get.helm.sh/helm-v3.14.4-linux-amd64.tar.gz && \
    tar -xf helm-*.tar.gz && \
    chmod +x linux-amd64/helm && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    helm version) && \
    rm -rf /tmp/helm

RUN --mount=type=bind,source=./scripts,target=/scripts /scripts/install_flux.sh

# RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash && \
#     mv ./kustomize /usr/local/bin/kustomize

RUN rm -rf /tmp/kubeseal && mkdir /tmp/kubeseal && (cd /tmp/kubeseal && \
    curl -LO https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.26.2/kubeseal-0.26.2-linux-amd64.tar.gz && \
    tar -xf kubeseal-*-linux-amd64.tar.gz && \
    chmod +x kubeseal && \
    mv kubeseal /usr/local/bin/kubeseal && \
    kubeseal --version) && \
    rm -rf /tmp/kubeseal

RUN rm -rf /tmp/k9s && mkdir /tmp/k9s && (cd /tmp/k9s && \
    curl -LO https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_linux_amd64.deb && \
    dpkg -i k9s_linux_amd64.deb && \
    k9s version) && \
    rm -rf /tmp/k9s

RUN kubectl completion bash > /etc/bash_completion.d/kubectl

RUN curl -fsSL https://tailscale.com/install.sh | sh

ENV FLUX_FORWARD_NAMESPACE=flux
