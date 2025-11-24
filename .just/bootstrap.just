set quiet
set shell := ['bash', '-eu', '-o', 'pipefail', '-c']

bootstrap_dir := justfile_dir() + '/bootstrap'
kubernetes_dir := justfile_dir() + '/kubernetes'

[private]
default:
    just --list bootsrap


[doc('Apply Kubernetes resources')]
resources:
    just log info "Running stage..." "stage" "$0"
    if ! just template "{{ bootstrap_dir }}/resources.yaml.j2" | kubectl apply --server-side --field-manager bootstrap --force-conflicts -f -; then \
        just log fatal "Failed to apply resources" "stage" "$0"; \
    fi;

[doc('Apply CRDs')]
crds: (with-banner "Applying CRDs")
    if ! crds=$(helmfile --file "{{bootstrap_dir}}/helmfile.d/00-crds.yaml" template -q | yq ea -e 'select(.kind == "CustomResourceDefinition")') || [[ -z "${crds}" ]]; then \
        just log fatal "Failed to render CRDs from Helmfile"; \
    fi; \
    if ! echo "${crds}" | kubectl diff --filename - &>/dev/null; then \
        if ! echo "${crds}" | kubectl apply --server-side --filename - &>/dev/null; then \
            just log fatal "Failed to apply crds from Helmfile"; \
        fi; \
    fi

[doc('Apply Apps')]
apps: (with-banner "Applying Apps")
    if ! helmfile --file "{{bootstrap_dir}}/helmfile.d/01-apps.yaml" sync --hide-notes; then \
        just log fatal "Failed to apply apps from Helmfile"; \
    fi

[private]
with-banner msg:
    just log info "{{msg}}"
