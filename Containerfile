# Will be replaced in the CI
FROM golang:1.21 AS builder

WORKDIR /src

COPY ./ ./

RUN go build -o /bin/openstack-test ./cmd/openshift-tests

# Will be replaced in the CI with registry.ci.openshift.org/ocp/4.y:tools
FROM registry.access.redhat.com/ubi8/ubi

COPY --from=builder /bin/openstack-test /usr/bin/

USER 1000:1000
ENV LC_ALL en_US.UTF-8

ENTRYPOINT ["/usr/bin/openstack-test"]
