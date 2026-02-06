# Changed Dirs Action

Detects which immediate subdirectories under a given path have changed files. Uses the GitHub API so it works with shallow checkouts — no `git fetch` needed.

## Inputs

| Input  | Description                                          | Required | Default |
| ------ | ---------------------------------------------------- | -------- | ------- |
| `path` | Parent directory to watch for changes (e.g., `jobs`) | `false`  | `.`     |

## Outputs

| Output        | Description                                                       |
| ------------- | ----------------------------------------------------------------- |
| `dirs`        | JSON array of changed directory names (e.g., `["api", "worker"]`) |
| `any` | Whether any directories changed (`true` or `false`)               |

## How It Works

| Event              | Method                                            |
| ------------------ | ------------------------------------------------- |
| `pull_request`     | GitHub API: PR changed files                      |
| `push`             | GitHub API: compare before/after commits          |
| `workflow_dispatch`| Lists all subdirectories (builds everything)      |

## Usage

```yaml
jobs:
  changed_dirs:
    runs-on: ubuntu-latest
    outputs:
      dirs: ${{ steps.changed_dirs.outputs.dirs }}
    steps:
      - uses: actions/checkout@v4
      - uses: atas/actions/changed-dirs@main
        id: changed_dirs
        with:
          path: jobs

  build:
    needs: changed_dirs
    if: needs.changed_dirs.outputs.dirs != '[]'
    strategy:
      matrix:
        dir: ${{ fromJson(needs.changed_dirs.outputs.dirs) }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "Changed dir: jobs/${{ matrix.dir }}"
```

## Notes

- ⚠️ The GitHub compare API (used for `push` events) returns a maximum of 300 changed files. Pushes changing more than 300 files may miss some directories.
- For higher security, pin to a specific commit SHA instead of `@main` (e.g., `atas/actions/changed-dirs@a1b2c3d`).
