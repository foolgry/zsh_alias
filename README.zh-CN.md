# Alias 管理工具

一个简单的 Zsh 别名管理工具，帮助你快速保存和持久化别名，方便重启终端后依然能够使用自定义的别名。

[English](https://github.com/foolgry/zsh_alias/blob/main/README.md) | 简体中文

## 功能特点

- **保存别名**：将定义的别名保存到文件中，确保下次启动终端时依然可用。
- **加载别名**：从保存的文件中加载别名，自动加载已保存的别名到当前会话中。

## 使用指南

### 1. 安装与配置

将以下代码添加到你的 `~/.zshrc` 文件中：

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

重新加载 Zsh 配置文件，自动加载已保存的 alias：

```zsh
source ~/.zshrc
```

### 2. 使用示例

#### 定义 alias 并保存：

首先，定义一个或多个 alias：

```zsh
alias a='ls -lah'
alias b='git status'
alias c='git push'
```

使用 `alias_save` 命令保存其中一个 alias，例如：

```zsh
alias_save b  # 保存 alias b 到 ~/.zsh_aliases 文件
```

#### 验证保存的 alias：

查看 `~/.zsh_aliases` 文件内容：

```sh
cat ~/.zsh_aliases
```

输出应该包含：

```sh
alias b='git status'
```

#### 在新的 Zsh 会话中验证 alias 已加载：

打开一个新的 Zsh 会话，或者在当前会话中执行以下命令：

```zsh
b  # 运行 'git status'
```

## 常见问题

### 1. 为什么我保存的 alias 在重启终端后失效？

确保你已经将 `load_aliases` 函数添加到了 `~/.zshrc` 文件中，并且在每次启动终端时自动调用该函数。

### 2. 如何删除已保存的 alias？

目前该工具仅支持保存和加载 alias，要删除已保存的 alias，可以手动编辑 `~/.zsh_aliases` 文件，删除对应的 alias 行，然后重新加载配置：

```zsh
source ~/.zshrc
```

## 贡献

欢迎大家为该项目贡献代码！如果你有新的功能需求或者发现了 bug，请提交 issue 或者 pull request。

## 许可证

该项目基于 MIT 许可证开源。详见 LICENSE 文件。

---

通过这个简单的 alias 管理工具，你可以轻松地在 Zsh 中管理和持久化你的 alias，让你的开发环境更加高效和个性化。