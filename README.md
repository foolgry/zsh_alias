# Alias Management Tool

A simple Zsh alias management tool that helps you quickly save and persist aliases, ensuring that your custom aliases remain available even after restarting the terminal.

English | [简体中文](https://github.com/foolgry/zsh_alias/blob/main/README.zh-CN.md)

## Features

- **Save Aliases**: Save defined aliases to a file to ensure they remain available in future terminal sessions.
- **Load Aliases**: Load aliases from the saved file, automatically adding them to the current session.

## Usage Guide

### 1. Installation and Configuration

Add the following code to your `~/.zshrc` file:

```zsh
# Function to save a specific alias
function alias_save {
  # Check if the alias exists
  if alias "$1" > /dev/null 2>&1; then
    # Extract the alias definition and ensure the correct format
    local alias_definition=$(alias "$1" | sed "s/^alias //")
    
    # Append the alias to the ~/.zsh_aliases file with alias prefix
    echo "alias $alias_definition" >> ~/.zsh_aliases
    
    echo "Alias $1 saved to ~/.zsh_aliases"
  else
    echo "Alias $1 does not exist"
  fi
}

# Function to load aliases
function load_aliases {
  if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
    echo "Aliases loaded from ~/.zsh_aliases"
  else
    echo "No alias file found."
  fi
}

# Automatically load aliases on shell startup
load_aliases
```

Reload your Zsh configuration file to automatically load the saved aliases:

```zsh
source ~/.zshrc
```

### 2. Usage Examples

#### Define and Save Aliases:

First, define one or more aliases:

```zsh
alias a='ls -lah'
alias b='git status'
alias c='git push'
```

Save one of the aliases using the `alias_save` command, for example:

```zsh
alias_save b  # Save alias b to ~/.zsh_aliases file
```

#### Verify Saved Aliases:

Check the contents of the `~/.zsh_aliases` file:

```sh
cat ~/.zsh_aliases
```

The output should include:

```sh
alias b='git status'
```


#### Verify Aliases are Loaded in a New Zsh Session:

Open a new Zsh session, or run the following command in the current session:

```zsh
b  # Run 'git status'
```

## Frequently Asked Questions

### 1. Why do my saved aliases disappear after restarting the terminal?

Make sure you have added the `load_aliases` function to your `~/.zshrc` file and that it is being called each time you start a terminal session.

### 2. How do I delete a saved alias?

Currently, this tool only supports saving and loading aliases. To delete a saved alias, manually edit the `~/.zsh_aliases` file to remove the corresponding alias line, then reload the configuration:

```zsh
source ~/.zshrc
```

## Contributions

We welcome contributions! If you have new feature requests or find any bugs, please submit an issue or a pull request.

## License

This project is open-sourced under the MIT license. See the LICENSE file for details.

---

With this simple alias management tool, you can easily manage and persist your aliases in Zsh, making your development environment more efficient and personalized.