# SSH Deploy Action

A reusable GitHub Action for setting up SSH and triggering a deployment script on a remote server. This action simplifies the process of deploying to remote servers by allowing you to configure SSH keys and ports securely through GitHub Secrets.

## Features

- Set up SSH with a private key and known hosts
- Trigger a deployment script on a remote server
- Securely pass SSH credentials through GitHub Secrets

## Inputs

| Input                | Description                                        | Required | Default |
| -------------------- | -------------------------------------------------- | -------- | ------- |
| `ssh_key`            | The private SSH key used to authenticate           | `true`   | N/A     |
| `ssh_port`           | The port to use for SSH                            | `true`   | `22`    |
| `ssh_host`           | The remote host to connect to via SSH              | `true`   | N/A     |
| `ssh_user`           | The SSH user to authenticate as                    | `true`   | N/A     |
| `deploy_script_path` | Path to the deployment script on the remote server | `true`   | N/A     |

## Usage

To use this action in your workflow, reference it as follows:

```yaml
jobs:
  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    environment: main
    steps:
      - name: Use SSH Deploy Action
        uses: atas/actions/ssh-deploy-action@v1
        with:
          ssh_key: ${{ secrets.SSH_KEY }}
          ssh_port: ${{ secrets.SSH_PORT }}
          ssh_host: ${{ secrets.SSH_HOST }}
          ssh_user: ${{ secrets.SSH_USER }}
          deploy_script_path: "/opt/swipetor/bin/pull-deploy/run.sh"
```
