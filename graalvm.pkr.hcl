source "docker" "ubuntu" {
  image = "ubuntu:20.04"
  commit = true
  changes = [
    "ENV M2_HOME=/opt/maven",
    "ENV GRAALVM_HOME=/opt/graalvm-ce-java11-20.1.0",
    "ENV PATH=$GRAALVM_HOME/bin:$M2_HOME/bin:$PATH",
    "ENTRYPOINT [\"\"]",
    "CMD [\"\"]"
  ]
}
build {
  sources = [
    "source.docker.ubuntu"
  ]

  provisioner "shell" {
    script = "build.sh"
  }

  post-processor "docker-tag" {
    repository = "graalvm"
    tag = [
      "20.1.0"
    ]
  }
}
