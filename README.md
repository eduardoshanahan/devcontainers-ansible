# Project Development Environment Setup using Visual Studio Code and Devcontainers

This repository is to be used as a starting point for other projects. The target is to have a setup that can be cloned and commited from the first time, with git working inside the devcontainer, and with correct access rights to not break if a commit is done in the local machine instead of VS Code.

## Prerequisites

- Ubuntu - I am running this in Ubuntu 24.10
- Docker installed and running
- Visual Studio Code installed
- VS Code Remote - Containers extension installed

## Setup Instructions

### Clone the Repository

Clone the project repository to your local machine:

```bash
git clone --depth 1 https://github.com/eduardoshanahan/devcontainers-git new-project-name
cd new-project-name
rm -rf .git/
```

### Configure Environment Variables

Copy the .env.example file to .env and update it with your details:

```bash
cp .devcontainer/.env.example .devcontainer/.env
```

Edit the .env file:

```bash
code .devcontainer/.env
```

Fill in the following details:

```dotenv
HOST_UID=1000 # Replace with your user's UID (run id -u to check)
HOST_GID=1000 # Replace with your user's GID (run id -g to check)
HOST_USERNAME="Your Name" # Replace with your user's name (run whoami to check)
GIT_USER_NAME="Your Name" # Replace with your Git username
GIT_USER_EMAIL="<your.email@example.com>" # Replace with your Git email
```

### Build and Launch the Dev Container

Open the project in VS Code:

Launch the Dev Container by running the provided script. This will ensure that all the environment variables are set correctly. Tis is important, because if they are empty VS Code will behave in strange ways (I saw the files missing, or root applied as the owner of the files created):

```bash
./launch_vscode.sh
```

### Verify the Setup

Once the Dev Container is running, verify the following:

- User Permissions: The container should run as the same user as your host machine, avoiding permission issues.

```bash
whoami
```

- Git Configuration: Check that Git is configured correctly by running:

```bash
git config --global --list
```

Ensure the user.name and user.email match the values you provided in the .env file.

## Work in the Dev Container

You can now work on the project inside the Dev Container. All Git operations (commits, pushes, etc.) will use the configured Git user, ensuring consistency across environments.

### Additional VS Code Settings

The .devcontainer/settings.json file includes recommended settings for the project, such as:

- Tab size: 4 spaces
- Format on save
- Default terminal shell: /bin/bash

These settings are automatically applied when working in the Dev Container.

## Troubleshooting

### Permission Issues

If you encounter permission issues, ensure that the HOST_UID and HOST_GID in the .env file match your host machine's user ID and group ID. You can check these values by running:

```bash
id -u # UID
id -g # GID
```

### Git Configuration

If Git is not configured correctly, you can manually set the Git user name and email inside the container:

```bash
git config --global user.name "Your Name"
git config --global user.email "<your.email@example.com>"
```

### Docker Issues

Ensure Docker is running and you have the necessary permissions to use it. If you encounter Docker-related issues, refer to the Docker documentation: <https://docs.docker.com/>

## Project Structure

```scss
git-base/
├── .devcontainer/
│   ├── Dockerfile
│   ├── devcontainer.json
│   ├── .env
│   └── .env.example
├── launch_vscode.sh
├── src/
│   └── ... (your source code)
├── README.md
└── ... (other project files)
```

- .devcontainer/
  - Dockerfile: Defines the Docker image for the Dev Container.
  - devcontainer.json: Configures the Dev Container for VS Code.
  - settings.json: Recommended VS Code settings for the project.
  - .env.example: Template for environment variables.
  - .env: Environment variables (created by you).
- launch_vscode.sh: Script to launch VS Code with the Dev Container.
- src/: Directory for the project content itself
