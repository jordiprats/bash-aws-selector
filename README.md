# bash-aws-selector

Interactive AWS profile and region switcher for the terminal, powered by [fzf](https://github.com/junegunn/fzf).

## Features

- **Profile switching** — fuzzy-search your `~/.aws/config` profiles with a live preview of each profile's settings
- **Region switching** — quickly swap between AWS regions (configured the relevent ones to you in the script itself)
- **Environment display** — show the active profile, region, and account ID in your prompt or on demand

## Prerequisites

- [fzf](https://github.com/junegunn/fzf)
- [AWS CLI](https://aws.amazon.com/cli/) (optional, used by `aws-env.sh` to resolve the account ID)

### Install fzf

```sh
# macOS
brew install fzf

# Debian / Ubuntu
sudo apt install fzf
```

## Installation

Clone the repository:

```sh
git clone https://github.com/jprats/bash-aws-selector.git
```

Add the following aliases to your shell configuration (`~/.bashrc`, `~/.zshrc`, etc.):

```sh
alias awsp='eval $(~/path/to/bash-aws-selector/aws-switch-profile.sh)'
alias awsr='eval $(~/path/to/bash-aws-selector/aws-switch-region.sh)'
```

Then reload your shell:

```sh
source ~/.bashrc  # or source ~/.zshrc
```

## Usage

### Switch AWS profile

```sh
awsp
```

Opens an interactive fzf picker listing all profiles from `~/.aws/config`. The currently active profile is shown in the header, and a preview pane shows the selected profile's configuration. Selecting a profile sets `AWS_PROFILE`.

### Switch AWS region

```sh
awsr
```

Opens an interactive fzf picker to choose an AWS region. Selecting a region sets both `AWS_REGION` and `AWS_DEFAULT_REGION`.

### Show current environment

```sh
./aws-env.sh
```

Prints the active profile, region, and (if credentials are valid) the AWS account ID:

```
my-profile @ us-east-1 (Account: 123456789012)
```

You can embed this in your shell prompt — for example in `PS1` or a [Starship](https://starship.rs/) custom command.

## Scripts

| Script | Purpose |
|---|---|
| `aws-switch-profile.sh` | Interactive profile selector (outputs `export AWS_PROFILE=…`) |
| `aws-switch-region.sh` | Interactive region selector (outputs `export AWS_REGION=…` and `export AWS_DEFAULT_REGION=…`) |
| `aws-env.sh` | Prints the current AWS profile, region, and account ID |
