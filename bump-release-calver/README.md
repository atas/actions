# bump-release-calver-action

Bumps the patch version of the latest release with calver versioning e.g. `2020.01.1` -> `2020.01.2`

## Usage

```
      - uses: atas/bump-release-calver-action@main
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
    ...
      - name: Read next version
        run: |
          next_version="${{ env.next_version }}"
```

It uses release api to fetch the latest version. If the last release is not calvar, it will create a new release with the initial version `2020.01.1`.
