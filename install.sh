#!/bin/sh

# 定义要添加的函数
FUNCTIONS=$(cat <<'EOF'
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
EOF
)

# 检查 .zshrc 文件是否存在
ZSHRC=~/.zshrc
if [ ! -f "$ZSHRC" ]; then
  touch "$ZSHRC"
fi

# 检查 .zshrc 是否已经包含这些函数
if ! grep -q "function alias_save" "$ZSHRC"; then
  echo "\n# Alias save and load functions" >> "$ZSHRC"
  echo "$FUNCTIONS" >> "$ZSHRC"
  echo "Alias functions added to $ZSHRC"
else
  echo "Alias functions already exist in $ZSHRC"
fi
