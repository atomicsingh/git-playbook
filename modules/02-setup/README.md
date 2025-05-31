# Module 2: Setting Up Git

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Install Git on any operating system
- Configure Git with your identity and preferences
- Set up SSH keys for secure authentication
- Create and connect to GitHub repositories
- Configure `.gitignore` files effectively

## 💻 Installing Git

### macOS Installation

#### Option 1: Using Homebrew (Recommended)
```bash
# Install Homebrew if you haven't already
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Git
brew install git
```

#### Option 2: Using Xcode Command Line Tools
```bash
# This will prompt you to install if not already installed
git --version
```

#### Option 3: Download from Git Website
1. Visit [git-scm.com/download/mac](https://git-scm.com/download/mac)
2. Download the latest version
3. Run the installer

### Windows Installation

#### Option 1: Git for Windows (Recommended)
1. Visit [gitforwindows.org](https://gitforwindows.org/)
2. Download Git for Windows
3. Run the installer with these recommended settings:
   - Use Visual Studio Code as Git's default editor (if you have VS Code)
   - Use Git from the command line and also from 3rd-party software
   - Use bundled OpenSSH
   - Use the OpenSSL library
   - Checkout Windows-style, commit Unix-style line endings
   - Use MinTTY (the default terminal of MSYS2)

#### Option 2: Using Windows Package Manager (winget)
```powershell
winget install --id Git.Git -e --source winget
```

#### Option 3: Using Chocolatey
```powershell
choco install git
```

### Linux Installation

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install git
```

#### CentOS/RHEL/Fedora
```bash
# CentOS/RHEL
sudo yum install git

# Fedora
sudo dnf install git
```

#### Arch Linux
```bash
sudo pacman -S git
```

### Verify Installation
```bash
git --version
# Should output something like: git version 2.39.0
```

## ⚙️ Configuring Git

### Essential Configuration

After installing Git, you need to set up your identity:

```bash
# Set your name (use your real name)
git config --global user.name "Your Full Name"

# Set your email (use the same email as your GitHub account)
git config --global user.email "your.email@example.com"
```

### Additional Useful Configurations

```bash
# Set default branch name to 'main'
git config --global init.defaultBranch main

# Enable colored output
git config --global color.ui auto

# Set default editor (choose one)
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim
git config --global core.editor "nano"         # Nano

# Configure line ending handling
# For Windows users:
git config --global core.autocrlf true
# For macOS/Linux users:
git config --global core.autocrlf input

# Set up helpful aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
```

### Configuration Levels

Git has three levels of configuration:

1. **System level** (`--system`): Applies to all users on the computer
2. **Global level** (`--global`): Applies to all repositories for your user
3. **Local level** (`--local`): Applies only to the current repository

```bash
# View all current configuration
git config --list

# View global configuration
git config --global --list

# View configuration for current repository
git config --local --list

# View where configuration values are set
git config --list --show-origin
```

## 🔐 SSH Keys vs HTTPS

### Understanding Authentication Methods

| Method | Pros | Cons | Best For |
|--------|------|------|----------|
| **HTTPS** | Simple setup, works everywhere | Need to enter credentials frequently | Beginners, quick setup |
| **SSH** | No password prompts, more secure | Initial setup complexity | Regular users, automation |

### Setting Up SSH Keys

SSH keys provide a secure, password-free way to connect to GitHub.

#### Step 1: Check for Existing SSH Keys
```bash
# List existing SSH keys
ls -la ~/.ssh

# Look for files named:
# id_rsa.pub, id_ecdsa.pub, id_ed25519.pub
```

#### Step 2: Generate a New SSH Key
```bash
# Generate SSH key (replace with your GitHub email)
ssh-keygen -t ed25519 -C "your.email@example.com"

# If your system doesn't support ed25519, use RSA:
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"

# When prompted for file location, press Enter for default
# When prompted for passphrase, you can enter one or leave blank
```

#### Step 3: Add SSH Key to SSH Agent
```bash
# Start the SSH agent
eval "$(ssh-agent -s)"

# Add your SSH private key to the ssh-agent
ssh-add ~/.ssh/id_ed25519
# or
ssh-add ~/.ssh/id_rsa
```

#### Step 4: Add SSH Key to GitHub

1. Copy your public key to clipboard:
```bash
# macOS
pbcopy < ~/.ssh/id_ed25519.pub

# Linux (install xclip if needed)
xclip -sel clip < ~/.ssh/id_ed25519.pub

# Windows Git Bash
clip < ~/.ssh/id_ed25519.pub

# Manual copy (if above don't work)
cat ~/.ssh/id_ed25519.pub
```

2. Add to GitHub:
   - Go to GitHub.com → Settings → SSH and GPG keys
   - Click "New SSH key"
   - Give it a descriptive title (e.g., "Work Laptop", "Personal MacBook")
   - Paste your public key
   - Click "Add SSH key"

#### Step 5: Test SSH Connection
```bash
ssh -T git@github.com

# You should see a message like:
# Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

### SSH Key Best Practices

1. **Use different keys for different purposes**:
   - Work computer
   - Personal computer
   - CI/CD systems

2. **Use descriptive titles** when adding keys to GitHub

3. **Regularly audit and remove unused keys**

4. **Use passphrases** for additional security (optional but recommended)

5. **Keep private keys secure** - never share or commit them

## 📁 Creating and Connecting to GitHub Repositories

### Creating a Repository on GitHub

#### Method 1: GitHub Web Interface
1. Go to [github.com](https://github.com) and sign in
2. Click the "+" icon → "New repository"
3. Fill in repository details:
   - **Repository name**: Use kebab-case (e.g., `my-awesome-project`)
   - **Description**: Brief description of your project
   - **Visibility**: Public or Private
   - **Initialize**: ✅ Add a README file
   - **Add .gitignore**: Choose appropriate template
   - **License**: Choose if open source

#### Method 2: GitHub CLI
```bash
# Install GitHub CLI first: https://cli.github.com/

# Create repository
gh repo create my-awesome-project --public --description "My awesome project"

# Create and clone in one step
gh repo create my-awesome-project --public --clone
```

### Connecting Local Repository to GitHub

#### Scenario 1: Clone Existing Repository
```bash
# Clone via HTTPS
git clone https://github.com/username/repository-name.git

# Clone via SSH (recommended)
git clone git@github.com:username/repository-name.git

# Clone to specific directory
git clone git@github.com:username/repository-name.git my-project-folder
```

#### Scenario 2: Connect Existing Local Repository
```bash
# In your existing project directory
git init

# Add remote origin
git remote add origin git@github.com:username/repository-name.git

# Verify remote
git remote -v

# Push existing code
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
```

### Understanding Remote URLs

```bash
# HTTPS URLs (require username/password or token)
https://github.com/username/repository.git

# SSH URLs (use SSH keys)
git@github.com:username/repository.git

# Change remote URL from HTTPS to SSH
git remote set-url origin git@github.com:username/repository.git

# View current remote URLs
git remote -v
```

## 🚫 .gitignore Basics

### What is .gitignore?

The `.gitignore` file tells Git which files and directories to ignore when tracking changes. This is crucial for:

- **Keeping sensitive data secure** (API keys, passwords)
- **Reducing repository size** (build artifacts, dependencies)
- **Avoiding conflicts** (OS-specific files, editor configurations)
- **Maintaining clean history** (log files, temporary files)

### .gitignore Syntax

```gitignore
# This is a comment

# Ignore specific file
secrets.txt

# Ignore all files with specific extension
*.log
*.tmp

# Ignore directory
node_modules/
build/

# Ignore files in any directory
**/temp
**/*.cache

# Negate pattern (don't ignore)
!important.log

# Ignore files only in root directory
/root-only-file.txt

# Ignore based on pattern
**/logs/*.log
```

### Common .gitignore Patterns

#### Universal Patterns
```gitignore
# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Editor files
*.swp
*.swo
*~
.vscode/
.idea/
*.sublime-*

# Log files
*.log
logs/

# Environment variables
.env
.env.local
.env.*.local
```

#### Language-Specific Examples

**Node.js**
```gitignore
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.npm
.yarn-integrity
dist/
build/
```

**Python**
```gitignore
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
env/
.venv
pip-log.txt
```

**Java**
```gitignore
*.class
*.jar
*.war
*.ear
target/
.gradle/
build/
```

**React/JavaScript**
```gitignore
node_modules/
build/
dist/
.env.local
.env.development.local
.env.test.local
.env.production.local
npm-debug.log*
```

### GitHub .gitignore Templates

GitHub provides excellent .gitignore templates:

1. **When creating a repository**, select appropriate .gitignore template
2. **For existing repositories**:
   ```bash
   # Download template (example for Node.js)
   curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore
   ```

3. **Popular templates**:
   - Node.js
   - Python
   - Java
   - Go
   - Ruby
   - Swift
   - Android
   - Unity

### Managing .gitignore

```bash
# Check what files are ignored
git status --ignored

# Force add ignored file (if needed)
git add -f filename.ext

# Remove file from tracking but keep locally
git rm --cached filename.ext

# Remove directory from tracking but keep locally
git rm -r --cached directory/

# Apply .gitignore to already tracked files
git rm -r --cached .
git add .
git commit -m "Apply .gitignore"
```

## 🛠️ Development Environment Setup

### Recommended Tools

#### Git GUI Clients
- **GitHub Desktop**: User-friendly, great for beginners
- **GitKraken**: Feature-rich, visual branch management
- **Sourcetree**: Free Atlassian tool
- **Tower**: Premium Mac/Windows client
- **Git Fork**: Fast and friendly Git client

#### IDE/Editor Integration
- **VS Code**: Excellent Git integration built-in
- **IntelliJ IDEA**: Powerful Git tools
- **Sublime Text**: Git plugins available
- **Vim**: Git plugins like fugitive

#### Command Line Enhancements
```bash
# Oh My Zsh with Git plugin (macOS/Linux)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Git aliases for common commands
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.up rebase
git config --global alias.ci commit
```

## 📋 Module 2 Exercises

### Exercise 1: Complete Setup
1. Install Git on your system
2. Configure your global Git settings
3. Generate SSH keys and add to GitHub
4. Create a test repository and clone it locally

### Exercise 2: .gitignore Practice
1. Create a new project directory
2. Add some files that should and shouldn't be tracked
3. Create an appropriate .gitignore file
4. Test that ignored files aren't tracked

### Exercise 3: Remote Configuration
1. Create a local Git repository
2. Connect it to a GitHub repository
3. Practice switching between HTTPS and SSH URLs
4. Push your first commit

## 🔧 Troubleshooting Common Issues

### Permission Denied (SSH)
```bash
# Check SSH agent
ssh-add -l

# Re-add key if needed
ssh-add ~/.ssh/id_ed25519

# Test connection
ssh -T git@github.com
```

### Wrong Email in Commits
```bash
# Fix last commit
git commit --amend --author="Name <email@example.com>"

# Fix multiple commits (interactive rebase)
git rebase -i HEAD~3
```

### Can't Push to Repository
```bash
# Check remote URL
git remote -v

# Check if you have write access
# Make sure you're pushing to a repo you own or have access to

# Try fetching first
git fetch origin
git push origin main
```

## ✅ Module 2 Checklist

Before moving to Module 3, ensure you can:

- [ ] Install Git on your operating system
- [ ] Configure Git with your name and email
- [ ] Generate and use SSH keys for authentication
- [ ] Create repositories on GitHub
- [ ] Clone repositories to your local machine
- [ ] Create and configure .gitignore files
- [ ] Connect local repositories to remote origins
- [ ] Push and pull code to/from GitHub

---

**Next Module**: [Module 3: Git Essentials](../03-essentials/README.md)
