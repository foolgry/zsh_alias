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