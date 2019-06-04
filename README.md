# Auto Merge GitHub Action

**Name:** `andyhansen/auto-merge-action`

Automatically merge from one branch into another when one is updated.
Will only attempt a merge when the branch specified in `FROM_BRANCH` is changed.

## Usage

This action requires access to your `GITHUB_TOKEN`, and supports two environment variables: `FROM_BRANCH` and `TO_BRANCH`.
Changes pushed to `FROM_BRANCH` will be automatically merged into `TO_BRANCH`.

- `FROM_BRANCH` defaults to `master`
- `TO_BRANCH` defaults to `uat`

### Example

An example `main.workflow` which updates the `uat` branch whenever changes are pushed `master`.
It uses [Filter for GitHub Actions](https://github.com/actions/bin/tree/3c0b4f0e63ea54ea5df2914b4fabf383368cd0da/filter) to make sure that it's only run when the master branch is changed.

```workflow
workflow "Keep uat up to date with master" {
  on = "push"
  resolves = ["Merge changes to uat"]
}

action "When master is updated" {
  uses = "actions/bin/filter@3c0b4f0e63ea54ea5df2914b4fabf383368cd0da"
  args = "branch master"
}

action "Merge changes to uat" {
  uses = "andyhansen/auto-merge-action@master"
  needs = ["When master is updated"]
  env = {
    FROM_BRANCH = "master"
    TO_BRANCH = "uat"
  }
  secrets = ["GITHUB_TOKEN"]
}
```
