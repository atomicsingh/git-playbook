# Git Troubleshooting Guide

This guide provides solutions for common Git issues you might encounter in your daily workflow.

## 🔄 Unable to Pull/Push Changes

### Problem: Cannot Pull Due to Local Changes

```bash
$ git pull origin main
error: Your local changes to the following files would be overwritten by merge:
    file.txt
Please commit your changes or stash them before you merge.
```

**Solutions:**

1. **Commit your changes:**
   ```bash
   git add .
   git commit -m "WIP: Save changes before pull"
   git pull origin main
   ```

2. **Stash your changes:**
   ```bash
   git stash
   git pull origin main
   git stash pop  # Apply stashed changes back
   ```

3. **Discard your changes (if not needed):**
   ```bash
   git restore .  # Git 2.23+
   # or
   git checkout -- .  # Older Git versions
   git pull origin main
   ```

### Problem: Push Rejected (Non-Fast-Forward)

```bash
$ git push origin main
error: failed to push some refs to 'origin/main'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
```

**Solutions:**

1. **Pull first, then push:**
   ```bash
   git pull origin main
   git push origin main
   ```

2. **Pull with rebase:**
   ```bash
   git pull --rebase origin main
   git push origin main
   ```

3. **Force push (use with extreme caution, only on personal branches):**
   ```bash
   git push --force-with-lease origin branch-name  # Safer force push
   ```

## 💥 Merge Conflicts

### Problem: Automatic Merge Failed

```bash
$ git merge feature-branch
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt
Automatic merge failed; fix conflicts and then commit the result.
```

**Solutions:**

1. **Resolve conflicts manually:**
   - Open conflicted files in your editor
   - Look for conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
   - Edit files to resolve conflicts
   - Save files
   ```bash
   git add .
   git commit -m "Resolve merge conflicts"
   ```

2. **Use merge tool:**
   ```bash
   git mergetool
   git commit -m "Resolve merge conflicts"
   ```

3. **Choose one version:**
   ```bash
   # Use current branch version
   git checkout --ours file.txt
   # OR use incoming branch version
   git checkout --theirs file.txt
   
   git add file.txt
   git commit -m "Resolve merge conflicts"
   ```

4. **Abort merge:**
   ```bash
   git merge --abort
   ```

## 🗑️ Accidental Changes

### Problem: Accidentally Committed to Wrong Branch

```bash
# You committed to main when you meant to commit to a feature branch
```

**Solutions:**

1. **Create branch at current position and reset main:**
   ```bash
   # Create new branch with your changes
   git branch feature-branch
   # Reset main to remote state
   git reset --hard origin/main
   # Switch to your new branch
   git checkout feature-branch
   ```

2. **Cherry-pick commit to correct branch:**
   ```bash
   # Get commit hash
   git log -1
   # Switch to correct branch
   git checkout feature-branch
   # Cherry-pick the commit
   git cherry-pick abc123
   # Go back to main and reset
   git checkout main
   git reset --hard HEAD~1  # Remove the commit
   ```

### Problem: Accidentally Deleted Branch

**Solutions:**

1. **Use reflog to find and restore:**
   ```bash
   # Find the deleted branch tip
   git reflog
   # Look for: abc123 (HEAD -> deleted-branch) commit message
   
   # Recreate branch
   git branch recovered-branch abc123
   ```

### Problem: Committed Sensitive Information

**Solutions:**

1. **If not pushed yet:**
   ```bash
   # Undo last commit but keep changes
   git reset --soft HEAD~1
   # Remove sensitive info
   # Commit again
   git commit -m "Re-commit without sensitive info"
   ```

2. **If already pushed (requires rewriting history):**
   ```bash
   # Use BFG Repo Cleaner or git-filter-repo (preferred over git filter-branch)
   # See: https://github.com/newren/git-filter-repo
   
   # Communicate with your team about the history rewrite!
   ```

## 🧹 Repository Issues

### Problem: Repository is Slow

**Solutions:**

1. **Garbage collection:**
   ```bash
   git gc
   ```

2. **Aggressive garbage collection:**
   ```bash
   git gc --aggressive
   ```

3. **Prune old objects:**
   ```bash
   git prune
   ```

### Problem: Large Repository Size

**Solutions:**

1. **Find large files:**
   ```bash
   git rev-list --objects --all | \
     git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
     sed -n 's/^blob //p' | \
     sort -k2nr | \
     head -10
   ```

2. **Convert to Git LFS:**
   ```bash
   # Install Git LFS if needed
   git lfs install
   # Track large file patterns
   git lfs track "*.psd"
   git lfs track "*.zip"
   # Add tracked files
   git add .gitattributes
   git add .
   git commit -m "Convert large files to LFS"
   ```

3. **Shallow clone for CI/CD:**
   ```bash
   git clone --depth=1 repository-url
   ```

## 🔄 Rebase Problems

### Problem: Rebase Conflicts

```bash
$ git rebase main
CONFLICT (content): Merge conflict in file.txt
error: could not apply abc123... commit message
```

**Solutions:**

1. **Resolve conflicts and continue:**
   ```bash
   # Edit conflicted files
   git add .
   git rebase --continue
   ```

2. **Skip problematic commit:**
   ```bash
   git rebase --skip
   ```

3. **Abort rebase:**
   ```bash
   git rebase --abort
   ```

### Problem: Interactive Rebase Gone Wrong

**Solutions:**

1. **Use reflog to recover:**
   ```bash
   git reflog
   # Find the state before rebase
   git reset --hard HEAD@{5}  # Adjust number as needed
   ```

## 🔒 Authentication Issues

### Problem: SSH Key Not Working

**Solutions:**

1. **Test SSH connection:**
   ```bash
   ssh -T git@github.com
   ```

2. **Add key to SSH agent:**
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

3. **Verify SSH key matches GitHub:**
   ```bash
   # Compare output with key in GitHub settings
   cat ~/.ssh/id_ed25519.pub
   ```

### Problem: HTTPS Authentication Fails

**Solutions:**

1. **Use credential helper:**
   ```bash
   # For macOS
   git config --global credential.helper osxkeychain
   
   # For Windows
   git config --global credential.helper wincred
   
   # For Linux
   git config --global credential.helper cache
   ```

2. **Create personal access token (for GitHub):**
   - Go to GitHub → Settings → Developer settings → Personal access tokens
   - Generate token with appropriate permissions
   - Use token as password when prompted

## 💻 Git GUI Issues

### Problem: Git GUI Tool Not Showing All Changes

**Solutions:**

1. **Refresh/restart the GUI tool**

2. **Check hidden files settings**

3. **Verify .gitignore isn't excluding files**

4. **Try command line to see actual status:**
   ```bash
   git status
   ```

## 🧠 Advanced Recovery

### Problem: Detached HEAD State

```bash
$ git status
HEAD detached at abc123
```

**Solutions:**

1. **Create a branch to save your work:**
   ```bash
   git branch temp-branch
   git checkout temp-branch
   ```

2. **Return to a branch:**
   ```bash
   git checkout main
   ```

### Problem: Corrupted Repository

**Solutions:**

1. **Check repository integrity:**
   ```bash
   git fsck --full
   ```

2. **Try to repair:**
   ```bash
   git reflog expire --expire=now --all
   git gc --prune=now --aggressive
   ```

3. **Clone fresh and copy changes:**
   ```bash
   # Last resort
   cd ..
   git clone repository-url fresh-repo
   # Manually copy uncommitted changes
   ```

## 🚨 Emergency Recovery Procedures

If you've tried the above solutions and still face issues, here are some emergency procedures:

1. **Make a complete backup:**
   ```bash
   # Copy entire repository including .git folder
   cp -r my-repo my-repo-backup
   ```

2. **Use external tools:**
   - [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) for removing large files/sensitive data
   - [git-filter-repo](https://github.com/newren/git-filter-repo) for complex history rewriting
   - [gitjk](https://github.com/mapmeld/gitjk) for undoing Git commands

3. **Contact expert help:**
   - Team Git expert
   - GitHub/GitLab support
   - Stack Overflow with [git] tag

Remember: Most Git mistakes can be recovered with the right approach, and `git reflog` is often your best friend in emergency situations!
