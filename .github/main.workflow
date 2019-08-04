workflow "Publish Helm chart" {
  on = "push"
  resolves = ["Helm gh-pages"]
}

action "Helm gh-pages" {
  uses = "sylus/gh-actions/helm-gh-pages@master"
  args = ["stable/*","https://statcan.github.io/charts"]
  secrets = ["GITHUB_TOKEN"]
}
