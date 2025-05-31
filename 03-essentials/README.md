# Module 3: Git Essentials

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Understand the core Git workflow: stage → commit → push → pull
- Create and clone repositories effectively
- Use essential Git commands for daily development
- Check repository status and view change history
- Safely undo changes using various Git commands

## 🔄 The Core Git Workflow

### Understanding Git's Three States

Every file in your Git repository can be in one of three states:

```
📁 Working Directory     📦 Staging Area     🗄️  Repository
   (Modified)          (Staged/Index)        (Committed)
        |                     |                   |
        |                     |                   |
    [git add] ──────────────→ |                   |
        |                     |                   |
        |              [git commit] ─────────────→ |
        |                     |                   |
        |                     |            [git push] ──→ 🌐 Remote
```

### The Four Essential Commands

1. **`git add`**: Move changes from working directory to staging area
2. **`git commit`**: Save staged changes to local repository
3. **`git push`**: Upload local commits to remote repository
4. **`git pull`**: Download changes from remote repository

### Basic Workflow Example

```bash
# 1. Make changes to files
echo "Hello World" > hello.txt

# 2. Check what changed
git status

# 3. Stage changes
git add hello.txt
# or stage all changes
git add .

# 4. Commit changes
git commit -m "Add hello world file"

# 5. Push to remote repository
git push origin main

# 6. Pull latest changes from remote
git pull origin main
```

## 📁 Creating and Cloning Repositories

### Creating a New Repository

#### Method 1: Initialize Local Repository
```bash
# Create new directory
mkdir my-project
cd my-project

# Initialize Git repository
git init

# Create initial file
echo "# My Project" > README.md

# Add and commit
git add README.md
git commit -m "Initial commit"

# Connect to remote repository
git remote add origin git@github.com:username/my-project.git
git branch -M main
git push -u origin main
```

#### Method 2: Clone Existing Repository
```bash
# Clone repository
git clone git@github.com:username/existing-project.git

# Change into directory
cd existing-project

# Start working!
```

### Understanding Clone vs Fork

| Action | Purpose | When to Use |
|--------|---------|-------------|
| **Clone** | Create local copy of repository | Working on projects you have access to |
| **Fork** | Create your own copy on GitHub | Contributing to projects you don't own |

```bash
# Clone (for repositories you have access to)
git clone git@github.com:company/project.git

# Fork process:
# 1. Click "Fork" on GitHub
# 2. Clone your fork
git clone git@github.com:yourusername/project.git
# 3. Add upstream remote
git remote add upstream git@github.com:company/project.git
```

## 📊 Checking Status and Logs

### Git Status - Your Best Friend

```bash
# Check repository status
git status

# Short status format
git status -s
```

**Understanding Git Status Output:**
```bash
$ git status
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    modified:   README.md
    new file:   src/app.js

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   package.json

Untracked files:
  (use "git add <file>..." to include in what will be committed)
    config.json
```

**Status Indicators:**
- `M` = Modified
- `A` = Added (new file)
- `D` = Deleted
- `R` = Renamed
- `C` = Copied
- `??` = Untracked

### Git Log - Understanding History

```bash
# Basic log
git log

# One line per commit
git log --oneline

# Show last 5 commits
git log -5

# Show commits with file changes
git log --stat

# Show commits with actual changes
git log -p

# Graphical representation
git log --graph --oneline --all

# Filter by author
git log --author="John Doe"

# Filter by date
git log --since="2 weeks ago"
git log --until="yesterday"

# Filter by commit message
git log --grep="bug fix"

# Show commits affecting specific file
git log -- filename.txt
```

**Useful Log Aliases:**
```bash
# Add these to your Git config
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.lga "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
```

### Git Diff - See What Changed

```bash
# Show unstaged changes
git diff

# Show staged changes
git diff --staged
# or
git diff --cached

# Compare specific commits
git diff commit1 commit2

# Compare branches
git diff main feature-branch

# Show changes for specific file
git diff filename.txt

# Show word-level differences
git diff --word-diff

# Show only file names that changed
git diff --name-only
```

## 🌐 Working with Remote Repositories

### Understanding Remotes

```bash
# List remote repositories
git remote -v

# Add remote repository
git remote add origin git@github.com:username/repo.git

# Add upstream remote (for forks)
git remote add upstream git@github.com:original/repo.git

# Change remote URL
git remote set-url origin git@github.com:username/new-repo.git

# Remove remote
git remote remove origin

# Rename remote
git remote rename origin destination
```

### Fetching vs Pulling

```bash
# Fetch: Download changes but don't merge
git fetch origin

# Pull: Fetch + merge in one command
git pull origin main

# Pull with rebase (recommended)
git pull --rebase origin main

# Set up tracking branch
git branch --set-upstream-to=origin/main main
# Now you can just use:
git pull
```

**When to use Fetch vs Pull:**
- **Use `git fetch`** when you want to see what's changed before merging
- **Use `git pull`** when you're ready to merge remote changes immediately

### Pushing Changes

```bash
# Push to specific branch
git push origin main

# Push and set upstream tracking
git push -u origin feature-branch

# Push all branches
git push --all origin

# Push tags
git push --tags origin

# Force push (use with caution!)
git push --force origin feature-branch
# Safer force push
git push --force-with-lease origin feature-branch
```

## ↩️ Undoing Changes Safely

### The Golden Rule of Git

**Never rewrite history that has been shared with others!**

### Undoing Changes - Decision Tree

```
Has the change been committed?
├─ No (Working Directory)
│  ├─ Discard all changes: git restore .
│  ├─ Discard specific file: git restore filename
│  └─ Unstage file: git restore --staged filename
│
└─ Yes (Committed)
   ├─ Has it been pushed?
   │  ├─ No (Local only)
   │  │  ├─ Undo last commit: git reset HEAD~1
   │  │  ├─ Undo and keep changes: git reset --soft HEAD~1
   │  │  └─ Undo completely: git reset --hard HEAD~1
   │  │
   │  └─ Yes (Shared)
   │     ├─ Create new commit: git revert <commit>
   │     └─ For multiple commits: git revert <commit1>..<commit2>
```

### Specific Undo Scenarios

#### 1. Unstaging Files
```bash
# Unstage specific file
git restore --staged filename.txt

# Unstage all files
git restore --staged .

# Old syntax (still works)
git reset HEAD filename.txt
```

#### 2. Discarding Working Directory Changes
```bash
# Discard changes to specific file
git restore filename.txt

# Discard all changes
git restore .

# Old syntax (still works)
git checkout -- filename.txt
```

#### 3. Undoing Commits (Local Only)
```bash
# Undo last commit, keep changes in working directory
git reset --soft HEAD~1

# Undo last commit, keep changes staged
git reset --mixed HEAD~1  # This is the default

# Undo last commit, discard all changes
git reset --hard HEAD~1

# Undo specific number of commits
git reset --soft HEAD~3  # Undo last 3 commits
```

#### 4. Reverting Commits (Safe for Shared History)
```bash
# Revert specific commit (creates new commit)
git revert abc123

# Revert without auto-commit (to modify message)
git revert --no-commit abc123

# Revert merge commit
git revert -m 1 abc123

# Revert range of commits
git revert HEAD~3..HEAD
```

#### 5. Fixing Commit Messages
```bash
# Fix last commit message
git commit --amend -m "Corrected commit message"

# Add forgotten files to last commit
git add forgotten-file.txt
git commit --amend --no-edit

# Change author of last commit
git commit --amend --author="Name <email@example.com>"
```

### Advanced Undo Techniques

#### Using Reflog (Git's Safety Net)
```bash
# Show reflog (history of HEAD movements)
git reflog

# Restore to previous state using reflog
git reset --hard HEAD@{2}

# Find lost commits
git reflog --all
```

#### Cherry-picking Specific Changes
```bash
# Apply specific commit to current branch
git cherry-pick abc123

# Cherry-pick multiple commits
git cherry-pick abc123 def456

# Cherry-pick without committing
git cherry-pick --no-commit abc123
```

## 🛠️ Essential Git Commands Reference

### Daily Commands
```bash
# Status and information
git status                    # Check repository status
git log --oneline            # View commit history
git diff                     # See unstaged changes
git diff --staged            # See staged changes

# Basic workflow
git add .                    # Stage all changes
git add filename             # Stage specific file
git commit -m "message"      # Commit with message
git push                     # Push to remote
git pull                     # Pull from remote

# Branch operations
git branch                   # List branches
git branch new-branch        # Create branch
git checkout branch-name     # Switch branch
git checkout -b new-branch   # Create and switch

# Merging
git merge branch-name        # Merge branch
git merge --no-ff branch     # Merge without fast-forward
```

### Information Commands
```bash
# Repository information
git remote -v                # Show remotes
git branch -a                # Show all branches
git tag                      # Show tags
git show commit-hash         # Show commit details

# File information
git blame filename           # Show who changed each line
git log --follow filename    # Show file history
git show HEAD:filename       # Show file at specific commit
```

### Configuration Commands
```bash
# View configuration
git config --list            # Show all config
git config user.name         # Show specific config

# Set configuration
git config --global user.name "Name"
git config --global user.email "email"
git config --global init.defaultBranch main
```

## 📋 Module 3 Exercises

### Exercise 1: Basic Workflow Practice
1. Create a new repository
2. Add several files
3. Practice staging changes selectively
4. Make multiple commits with meaningful messages
5. Push to remote repository

### Exercise 2: Status and Log Exploration
1. Make various changes to files
2. Use `git status` to understand different states
3. Use different `git log` options to explore history
4. Practice using `git diff` to see changes

### Exercise 3: Undo Operations
1. Create some commits
2. Practice undoing changes at different stages:
   - Unstaging files
   - Discarding working directory changes
   - Undoing commits (locally)
   - Reverting commits

### Exercise 4: Remote Operations
1. Clone a repository
2. Make changes and push them
3. Simulate conflicts by making changes in two places
4. Practice pulling and resolving issues

## 🔧 Troubleshooting Common Issues

### "Your branch is ahead of origin/main"
```bash
# You have local commits not pushed yet
git push origin main
```

### "Your branch is behind origin/main"
```bash
# Remote has new commits you don't have
git pull origin main
```

### "Your branch has diverged"
```bash
# Both local and remote have different commits
git pull --rebase origin main
# or
git pull origin main  # creates merge commit
```

### "Nothing to commit, working tree clean"
```bash
# No changes detected
# Check if you're in the right directory
pwd
git status
```

### "Fatal: not a git repository"
```bash
# You're not in a Git repository
# Either initialize one or navigate to existing repo
git init
# or
cd /path/to/git/repo
```

## 💡 Best Practices

### Commit Best Practices
1. **Make atomic commits**: Each commit should represent one logical change
2. **Write descriptive commit messages**: Explain what and why, not how
3. **Commit frequently**: Small, frequent commits are easier to manage
4. **Test before committing**: Ensure your code works before committing

### Working Directory Best Practices
1. **Keep working directory clean**: Commit or stash changes before switching branches
2. **Use .gitignore**: Prevent accidental commits of unwanted files
3. **Review changes before staging**: Use `git diff` to review what you're committing
4. **Stage related changes together**: Group related changes in single commits

### Remote Repository Best Practices
1. **Pull before pushing**: Always get latest changes before pushing yours
2. **Use descriptive branch names**: Make branch purpose clear
3. **Don't force push to shared branches**: Respect others' work
4. **Communicate with team**: Let others know about significant changes

## ✅ Module 3 Checklist

Before moving to Module 4, ensure you can:

- [ ] Understand Git's three states (working, staging, committed)
- [ ] Execute the basic Git workflow (add, commit, push, pull)
- [ ] Create and clone repositories
- [ ] Use git status, log, and diff effectively
- [ ] Safely undo changes at different stages
- [ ] Work with remote repositories
- [ ] Troubleshoot common Git issues
- [ ] Follow basic Git best practices

---

**Next Module**: [Module 4: Branching & Merging](../04-branching/README.md)

# Example branch naming
feature/new-feature
fix/bug-description
hotfix/urgent-fix
