# Git Command Cheat Sheet

## 🚀 Getting Started

| Command | Description |
|---------|-------------|
| `git init` | Initialize a new Git repository |
| `git clone <url>` | Clone a repository from URL |
| `git config --global user.name "Name"` | Set your name |
| `git config --global user.email "email"` | Set your email |
| `git config --list` | Show configuration |

## 📋 Basic Workflow

| Command | Description |
|---------|-------------|
| `git status` | Show working tree status |
| `git add <file>` | Add file to staging area |
| `git add .` | Add all changes to staging area |
| `git commit -m "message"` | Commit staged changes |
| `git commit -am "message"` | Add and commit in one step |
| `git push origin <branch>` | Push to remote repository |
| `git pull origin <branch>` | Pull from remote repository |
| `git fetch origin` | Fetch changes without merging |

## 🌿 Branching

| Command | Description |
|---------|-------------|
| `git branch` | List branches |
| `git branch <name>` | Create branch |
| `git checkout <branch>` | Switch to branch |
| `git checkout -b <branch>` | Create and switch to branch |
| `git switch <branch>` | Switch to branch (Git 2.23+) |
| `git switch -c <branch>` | Create and switch (Git 2.23+) |
| `git merge <branch>` | Merge branch into current branch |
| `git branch -d <branch>` | Delete branch (safe) |
| `git branch -D <branch>` | Force delete branch |
| `git push origin --delete <branch>` | Delete remote branch |

## 🔍 Inspecting

| Command | Description |
|---------|-------------|
| `git log` | Show commit history |
| `git log --oneline` | Compact history view |
| `git log --graph --oneline` | Graphical history |
| `git diff` | Show unstaged changes |
| `git diff --staged` | Show staged changes |
| `git blame <file>` | Show who changed each line |
| `git show <commit>` | Show commit details |

## ↩️ Undoing Changes

| Command | Description |
|---------|-------------|
| `git restore <file>` | Discard changes (Git 2.23+) |
| `git restore --staged <file>` | Unstage changes (Git 2.23+) |
| `git checkout -- <file>` | Discard changes (old syntax) |
| `git reset HEAD <file>` | Unstage changes (old syntax) |
| `git reset --soft HEAD~1` | Undo last commit, keep changes |
| `git reset --hard HEAD~1` | Undo last commit, discard changes |
| `git revert <commit>` | Create new commit that undoes changes |
| `git commit --amend` | Modify the last commit |

## 📦 Stashing

| Command | Description |
|---------|-------------|
| `git stash` | Stash changes |
| `git stash push -m "message"` | Stash with description |
| `git stash list` | List stashes |
| `git stash apply` | Apply most recent stash |
| `git stash apply stash@{n}` | Apply specific stash |
| `git stash pop` | Apply and remove stash |
| `git stash drop stash@{n}` | Delete specific stash |
| `git stash clear` | Delete all stashes |

## 🔄 Remote Repositories

| Command | Description |
|---------|-------------|
| `git remote -v` | List remotes |
| `git remote add <name> <url>` | Add remote |
| `git remote remove <name>` | Remove remote |
| `git remote set-url <name> <url>` | Change remote URL |
| `git push -u origin <branch>` | Push and set upstream |
| `git push --force-with-lease` | Safer force push |
| `git fetch --prune` | Fetch and remove deleted remote branches |

## 🍒 Advanced Commands

| Command | Description |
|---------|-------------|
| `git cherry-pick <commit>` | Apply commit to current branch |
| `git rebase <branch>` | Rebase current branch onto another |
| `git rebase -i HEAD~3` | Interactive rebase |
| `git reflog` | Show reference logs |
| `git bisect start` | Start binary search for bugs |
| `git bisect good/bad` | Mark commit as good/bad |
| `git bisect reset` | End binary search |
| `git worktree add <path> <branch>` | Add working tree |

## 🏷️ Tags

| Command | Description |
|---------|-------------|
| `git tag` | List tags |
| `git tag <name>` | Create lightweight tag |
| `git tag -a <name> -m "message"` | Create annotated tag |
| `git push origin <tagname>` | Push tag to remote |
| `git push origin --tags` | Push all tags |
| `git tag -d <tagname>` | Delete tag |

## 🧹 Maintenance

| Command | Description |
|---------|-------------|
| `git gc` | Garbage collection |
| `git prune` | Remove unreachable objects |
| `git fsck` | Check repository integrity |
| `git clean -fd` | Remove untracked files |
| `git count-objects -vH` | Count objects and size |

## 🤝 GitHub CLI Commands

| Command | Description |
|---------|-------------|
| `gh repo create` | Create a repository |
| `gh pr create` | Create a pull request |
| `gh pr checkout <number>` | Checkout PR locally |
| `gh issue create` | Create an issue |
| `gh release create <tag>` | Create a release |

## 💻 Git GUI Tools

- **GitKraken**: Cross-platform, visual, powerful
- **Sourcetree**: Free for Windows/Mac
- **GitHub Desktop**: Simple, focused on GitHub
- **VS Code Git**: Integrated in VS Code
- **Git Extensions**: Windows UI for Git

## 📱 Mobile Apps

- **Working Copy**: iOS Git client
- **GitJournal**: Git-based note-taking
- **GitTouch**: GitHub/GitLab/Bitbucket client
