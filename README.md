![Docker](https://github.com/SchwarzIT/graalvm-packer/workflows/Docker/badge.svg?branch=20.1.0)
[![SIT](https://img.shields.io/badge/SIT-awesome-blueviolet.svg)](https://jobs.schwarz)

# GRAALVM BY UBUNTU

Two ways to build this:

## Via Packer
### oldschool json
```
packer build graalvm.json
```
### new school HCL
```
packer build .
```

As we want to use it in Azure DevOps as a container image, we need to take care that the ENTRYPOINT is not set. 

>Linux-based containers
 The Azure Pipelines system requires a few things in Linux-based containers:
 Bash
 glibc-based
 Can run Node.js (which the agent provides)
 Does not define an ENTRYPOINT
 USER has access to groupadd and other privileges commands without sudo

https://docs.microsoft.com/en-us/azure/devops/pipelines/process/container-phases?view=azure-devops

So we use this hint from the good folks of github. https://github.com/hashicorp/packer/issues/7487 and add in the packer file the 
```
 "changes": [
        "ENTRYPOINT [\"\"]",
        "CMD [\"\"]"
      ]
```

## Via Docker BuildKit
```
DOCKER_BUILDKIT=1 docker build --tag <repo|empty>/graalvm:20.1.0  .
```
