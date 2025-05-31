# Git Quick Reference Guide

## 📚 Essential Commands

### Repository Setup
```bash
git init                    # Initialize new repository
git clone <url>             # Clone existing repository
git remote add origin <url> # Add remote repository
git remote -v               # View remotes
```

### Basic Workflow
```bash
git status                  # Check repository status
git add <file>              # Stage specific file
git add .                   # Stage all changes
git commit -m "message"     # Commit with message
git push origin <branch>    # Push to remote
git pull origin <branch>    # Pull from remote
```

### Branching
```bash
git branch                  # List local branches
git branch <name>           # Create new branch
git checkout <branch>       # Switch to branch
git checkout -b <branch>    # Create and switch to branch
git merge <branch>          # Merge branch
git branch -d <branch>      # Delete branch
```

### Information
```bash
git log                     # View commit history
git log --oneline           # Compact log
git diff                    # Show unstaged changes
git diff --staged           # Show staged changes
git show <commit>           # Show specific commit
```

### Undoing Changes
```bash
git restore <file>          # Discard working directory changes
git restore --staged <file> # Unstage file
git reset HEAD~1            # Undo last commit (keep changes)
git reset --hard HEAD~1     # Undo last commit (discard changes)
git revert <commit>         # Create commit that undoes another commit
```

## 🔧 Advanced Commands

### Stashing
```bash
git stash                   # Stash current changes
git stash list              # List all stashes
git stash apply             # Apply most recent stash
git stash pop               # Apply and remove most recent stash
git stash drop              # Delete a stash
```

### Rebasing
```bash
git rebase <branch>         # Rebase current branch onto another
git rebase -i HEAD~3        # Interactive rebase of last 3 commits
git rebase --continue       # Continue rebase after resolving conflicts
git rebase --abort          # Abort rebase operation
```

### Cherry-picking
```bash
git cherry-pick <commit>    # Apply specific commit to current branch
git cherry-pick <commit1>..<commit2>  # Cherry-pick range of commits
```

### Tagging
```bash
git tag                     # List tags
git tag <tagname>           # Create lightweight tag
git tag -a <tagname> -m "message"  # Create annotated tag
git push origin <tagname>   # Push tag to remote
git push origin --tags      # Push all tags
```

## 🚨 Emergency Commands

### Recovery
```bash
git reflog                  # Show reference log
git fsck                    # Check repository integrity
git gc                      # Garbage collection
```

### Conflict Resolution
```bash
git mergetool               # Open merge tool
git checkout --ours <file>  # Take our version
git checkout --theirs <file> # Take their version
```

## 📝 Configuration

### User Setup
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

### Useful Aliases
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
```

## 🔍 Searching

```bash
git log --grep="keyword"     # Search commit messages
git log -S "code"           # Search for code changes
git log --author="name"     # Filter by author
git blame <file>            # Show who changed each line
```

## 📊 Statistics

```bash
git log --stat              # Show file change statistics
git shortlog -sn            # Contributor statistics
git log --since="2 weeks ago" # Commits in time range
```
