# Module 7: Advanced Git Commands

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Use advanced Git commands like stash, cherry-pick, and bisect
- Perform interactive rebasing to clean up commit history
- Manage and clean up old branches effectively
- Recover lost commits using reflog
- Set up and use Git hooks for automation
- Optimize Git performance and repository maintenance

## 📋 Git Stash - Temporary Storage

### What is Git Stash?

Git stash temporarily saves your uncommitted changes so you can work on something else, then come back and apply them later.

**Common scenarios:**
- Need to quickly switch branches
- Pull latest changes but have uncommitted work
- Emergency bug fix interrupts current work
- Want to test something without committing

### Basic Stash Operations

```bash
# Stash current changes
git stash
# or
git stash push -m "Work in progress on feature X"

# List all stashes
git stash list
# Output: stash@{0}: On main: Work in progress on feature X

# Apply most recent stash
git stash apply

# Apply and remove most recent stash
git stash pop

# Apply specific stash
git stash apply stash@{2}

# Drop (delete) a stash
git stash drop stash@{0}

# Clear all stashes
git stash clear
```

### Advanced Stash Techniques

#### Partial Stashing
```bash
# Stash only specific files
git stash push -m "Stash specific files" -- file1.js file2.css

# Stash with interactive selection
git stash push -p

# Stash untracked files too
git stash push -u -m "Include untracked files"

# Stash everything including ignored files
git stash push -a -m "Include all files"
```

#### Stash Branching
```bash
# Create branch from stash
git stash branch new-feature-branch stash@{0}

# This will:
# 1. Create new branch from commit where stash was created
# 2. Check out the new branch
# 3. Apply the stash
# 4. Drop the stash if applied successfully
```

#### Stash Inspection
```bash
# Show stash contents
git stash show
git stash show -p  # Show full diff
git stash show stash@{1}  # Show specific stash

# Compare stash with current working directory
git diff stash@{0}
```

### Stash Best Practices

1. **Use descriptive messages**: `git stash push -m "Half-finished login validation"`
2. **Clean up regularly**: Don't let stashes accumulate
3. **Prefer short-term use**: Stash is for temporary storage, not long-term
4. **Consider committing instead**: For work you want to keep long-term

## 🍒 Cherry-Pick - Selective Commits

### What is Cherry-Pick?

Cherry-pick applies specific commits from one branch to another, useful for:
- Applying bug fixes to multiple branches
- Moving specific features between branches
- Backporting changes to older versions

### Basic Cherry-Pick

```bash
# Apply specific commit to current branch
git cherry-pick abc123

# Cherry-pick multiple commits
git cherry-pick abc123 def456 ghi789

# Cherry-pick range of commits
git cherry-pick abc123..def456

# Cherry-pick without committing (stage changes only)
git cherry-pick --no-commit abc123

# Cherry-pick and edit commit message
git cherry-pick --edit abc123
```

### Handling Cherry-Pick Conflicts

```bash
# When conflicts occur during cherry-pick
$ git cherry-pick abc123
Error: could not apply abc123... commit message
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

# Resolve conflicts, then:
git add .
git cherry-pick --continue

# Or abort cherry-pick
git cherry-pick --abort

# Skip problematic commit
git cherry-pick --skip
```

### Cherry-Pick Best Practices

```bash
# ✅ Good use cases
# Hot fix to multiple release branches
git checkout release/v1.0
git cherry-pick hotfix-commit
git checkout release/v2.0
git cherry-pick hotfix-commit

# Backport feature to older version
git checkout v1.x-maintenance
git cherry-pick feature-commit

# ❌ Avoid cherry-picking
# Large feature sets (use merge instead)
# Commits that depend on other commits
# When entire branch should be merged
```

## 🔍 Git Bisect - Bug Detective

### What is Git Bisect?

Git bisect uses binary search to find the commit that introduced a bug. It's incredibly efficient for debugging.

### Basic Bisect Workflow

```bash
# Start bisect session
git bisect start

# Mark current commit as bad (has the bug)
git bisect bad

# Mark a known good commit (doesn't have the bug)
git bisect good v1.0.0
# or
git bisect good abc123

# Git will checkout a commit in the middle
# Test the code, then mark it:
git bisect good    # if no bug
# or
git bisect bad     # if bug exists

# Repeat until Git finds the problematic commit
# Git will show: "abc123 is the first bad commit"

# End bisect session
git bisect reset
```

### Automated Bisect

```bash
# Automate with a test script
git bisect start
git bisect bad HEAD
git bisect good v1.0.0

# Run automated bisect with test script
git bisect run ./test-script.sh

# Example test script (test-script.sh)
#!/bin/bash
npm test
exit $?  # Exit with test result
```

### Bisect Example Scenario

```bash
# Scenario: Login feature worked in v2.0 but broken in current main

# 1. Start bisect
git bisect start
git bisect bad main        # Current version is broken
git bisect good v2.0.0     # This version worked

# 2. Git checks out middle commit
# Test the login feature manually or run tests

# 3. Mark result and continue
git bisect good  # Login works in this commit
# Git checks out another commit

# 4. Repeat until found
# Git output: "commit abc123 is the first bad commit"

# 5. Examine the bad commit
git show abc123

# 6. End bisect
git bisect reset
```

## 🔄 Interactive Rebase - History Editing

### What is Interactive Rebase?

Interactive rebase allows you to modify commit history by:
- Reordering commits
- Combining (squashing) commits
- Editing commit messages
- Removing commits
- Splitting commits

### Starting Interactive Rebase

```bash
# Rebase last 3 commits
git rebase -i HEAD~3

# Rebase from specific commit
git rebase -i abc123

# Rebase from root (all commits)
git rebase -i --root
```

### Interactive Rebase Commands

When you run interactive rebase, you'll see an editor with options:

```bash
pick abc123 Add user authentication
pick def456 Fix typo in login form
pick ghi789 Add password validation
pick jkl012 Fix authentication bug

# Rebase commands:
# p, pick = use commit
# r, reword = use commit, but edit the commit message
# e, edit = use commit, but stop for amending
# s, squash = use commit, but meld into previous commit
# f, fixup = like "squash", but discard this commit's log message
# d, drop = remove commit
```

### Common Interactive Rebase Scenarios

#### 1. Squashing Related Commits
```bash
# Original commits:
pick abc123 Add user authentication
pick def456 Fix typo in login form
pick ghi789 Add password validation
pick jkl012 Fix authentication bug

# After editing (squash related commits):
pick abc123 Add user authentication
fixup def456 Fix typo in login form
pick ghi789 Add password validation
fixup jkl012 Fix authentication bug

# Result: 2 clean commits instead of 4
```

#### 2. Reordering Commits
```bash
# Original order:
pick abc123 Add feature A
pick def456 Add feature B
pick ghi789 Fix bug in feature A

# Reordered:
pick abc123 Add feature A
pick ghi789 Fix bug in feature A
pick def456 Add feature B
```

#### 3. Editing Commit Messages
```bash
# Change "pick" to "reword" for commits you want to edit
reword abc123 Add user authentication
pick def456 Fix typo in login form

# Git will open editor for each "reword" commit
```

#### 4. Splitting a Commit
```bash
# Mark commit for editing
edit abc123 Add multiple features

# When Git stops at the commit:
git reset HEAD~1          # Unstage the changes
git add feature1.js       # Stage first feature
git commit -m "Add feature 1"
git add feature2.js       # Stage second feature
git commit -m "Add feature 2"
git rebase --continue     # Continue rebase
```

### Interactive Rebase Best Practices

**✅ When to use:**
- Cleaning up feature branch before merging
- Fixing commit messages
- Combining "work in progress" commits
- Removing accidentally committed files

**❌ Never rebase:**
- Commits that have been pushed to shared branches
- Public repositories others are using
- Main/master branch with team members

## 🧹 Branch Cleanup and Management

### Identifying Branches to Clean

```bash
# List all branches
git branch -a

# List merged branches
git branch --merged main

# List unmerged branches
git branch --no-merged main

# List branches with last commit info
git for-each-ref --format='%(refname:short) %(committerdate)' refs/heads | sort -k2

# Show branches older than 30 days
git for-each-ref --format='%(refname:short) %(committerdate:relative)' refs/heads | grep -E '[0-9]+ (month|year)'
```

### Safe Branch Deletion

```bash
# Delete merged branch (safe)
git branch -d feature/completed-feature

# Force delete unmerged branch (use with caution)
git branch -D feature/abandoned-feature

# Delete remote branch
git push origin --delete feature/old-feature

# Delete local tracking branch
git branch -dr origin/feature/old-feature
```

### Bulk Branch Cleanup

```bash
# Delete all merged branches except main
git branch --merged main | grep -v "main" | xargs -n 1 git branch -d

# Clean up remote tracking branches that no longer exist
git remote prune origin

# More aggressive cleanup
git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d
```

### Branch Cleanup Script

```bash
#!/bin/bash
# cleanup-branches.sh

echo "🧹 Starting branch cleanup..."

# Update remote references
echo "Fetching latest remote information..."
git fetch -p

# Show branches to be deleted
echo "\nBranches that will be deleted:"
git branch --merged main | grep -v "main" | sed 's/^/  - /'

# Confirm deletion
read -p "\nProceed with deletion? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Delete merged branches
    git branch --merged main | grep -v "main" | xargs -n 1 git branch -d
    
    # Clean up tracking branches
    git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -d
    
    echo "✅ Cleanup complete!"
else
    echo "❌ Cleanup cancelled."
fi
```

## 🔄 Git Reflog - Recovery Tool

### What is Reflog?

Reflog (reference log) records when the tips of branches and other references were updated in the local repository. It's your safety net for recovering "lost" commits.

### Using Reflog

```bash
# Show reflog for current branch
git reflog

# Show reflog for specific branch
git reflog main

# Show reflog for all references
git reflog --all

# Show reflog with dates
git reflog --date=iso

# Show last 10 entries
git reflog -10
```

### Recovery Scenarios

#### 1. Recovering Accidentally Reset Commits

```bash
# Scenario: You did a hard reset and lost commits
git reset --hard HEAD~3  # Oops! Lost 3 commits

# Find the lost commits in reflog
git reflog
# Output shows: abc123 HEAD@{1}: commit: Important feature

# Recover the commits
git reset --hard abc123
# or create a new branch
git checkout -b recovery-branch abc123
```

#### 2. Recovering Deleted Branch

```bash
# Scenario: Accidentally deleted a branch
git branch -D important-feature  # Oops!

# Find the branch tip in reflog
git reflog --all | grep "important-feature"
# Output: def456 refs/heads/important-feature@{0}: commit: Final feature implementation

# Recreate the branch
git checkout -b important-feature def456
```

#### 3. Recovering from Bad Merge

```bash
# Scenario: Merge went wrong
git merge feature-branch  # Merge created issues

# Find state before merge
git reflog
# Output: ghi789 HEAD@{1}: commit (before merge)

# Reset to state before merge
git reset --hard ghi789
```

### Reflog Cleanup

```bash
# Reflog entries expire automatically (default: 90 days)
# Manual cleanup (use carefully):
git reflog expire --expire=30.days refs/heads/main

# Delete all reflog entries
git reflog delete --all

# Configure reflog expiration
git config gc.reflogExpire "60 days"
git config gc.reflogExpireUnreachable "30 days"
```

## 🪝 Git Hooks - Automation

### What are Git Hooks?

Git hooks are scripts that run automatically when certain Git events occur. They enable you to:
- Enforce coding standards
- Run tests before commits
- Validate commit messages
- Send notifications
- Deploy automatically

### Types of Git Hooks

#### Client-Side Hooks
```bash
# Pre-commit: Before commit is created
pre-commit

# Prepare-commit-msg: Before commit message editor
prepare-commit-msg

# Commit-msg: Validate commit message
commit-msg

# Post-commit: After commit is created
post-commit

# Pre-rebase: Before rebase
pre-rebase

# Post-checkout: After checkout
post-checkout

# Post-merge: After merge
post-merge
```

#### Server-Side Hooks
```bash
# Pre-receive: Before push is accepted
pre-receive

# Update: Before each branch is updated
update

# Post-receive: After push is accepted
post-receive
```

### Setting Up Git Hooks

Hooks are stored in `.git/hooks/` directory:

```bash
# List available hooks
ls .git/hooks/

# Sample hooks end with .sample
# Remove .sample to activate
mv .git/hooks/pre-commit.sample .git/hooks/pre-commit

# Make hook executable
chmod +x .git/hooks/pre-commit
```

### Example Git Hooks

#### 1. Pre-commit Hook (Code Quality)

```bash
#!/bin/sh
# .git/hooks/pre-commit

echo "🔍 Running pre-commit checks..."

# Run linter
echo "Running ESLint..."
npm run lint
if [ $? -ne 0 ]; then
    echo "❌ Linting failed. Please fix errors before committing."
    exit 1
fi

# Run tests
echo "Running tests..."
npm test
if [ $? -ne 0 ]; then
    echo "❌ Tests failed. Please fix tests before committing."
    exit 1
fi

# Check for debugging statements
echo "Checking for debugging statements..."
if git diff --cached --name-only | xargs grep -l "console.log\|debugger" 2>/dev/null; then
    echo "❌ Found debugging statements. Please remove before committing."
    exit 1
fi

echo "✅ All pre-commit checks passed!"
exit 0
```

#### 2. Commit-msg Hook (Message Validation)

```bash
#!/bin/sh
# .git/hooks/commit-msg

commit_regex='^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .{1,50}'

if ! grep -qE "$commit_regex" "$1"; then
    echo "❌ Invalid commit message format!"
    echo "Format: type(scope): description"
    echo "Examples:"
    echo "  feat(auth): add login functionality"
    echo "  fix(ui): resolve button alignment issue"
    echo "  docs: update API documentation"
    exit 1
fi

echo "✅ Commit message format is valid!"
exit 0
```

#### 3. Post-commit Hook (Notifications)

```bash
#!/bin/sh
# .git/hooks/post-commit

# Get commit information
commit_hash=$(git rev-parse HEAD)
commit_message=$(git log -1 --pretty=%B)
author=$(git log -1 --pretty=%an)
branch=$(git rev-parse --abbrev-ref HEAD)

# Send notification (example with curl to Slack)
curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"📝 New commit by $author on $branch\\n$commit_message\\n$commit_hash\"}" \
    YOUR_SLACK_WEBHOOK_URL

echo "📬 Notification sent!"
```

### Sharing Hooks with Team

Since `.git/hooks/` is not tracked, share hooks via:

#### 1. Scripts Directory
```bash
# Create hooks directory in project
mkdir scripts/hooks

# Add hooks
cp .git/hooks/pre-commit scripts/hooks/

# Setup script for team members
#!/bin/bash
# scripts/setup-hooks.sh
cp scripts/hooks/* .git/hooks/
chmod +x .git/hooks/*
echo "✅ Git hooks installed!"
```

#### 2. Using Husky (Node.js projects)
```bash
# Install Husky
npm install --save-dev husky

# Initialize Husky
npx husky install

# Add pre-commit hook
npx husky add .husky/pre-commit "npm test"

# Package.json script
{
  "scripts": {
    "prepare": "husky install"
  }
}
```

### Hook Best Practices

1. **Keep hooks fast**: Slow hooks frustrate developers
2. **Make hooks skippable**: `git commit --no-verify` for emergencies
3. **Provide clear error messages**: Help developers fix issues
4. **Test hooks thoroughly**: Bad hooks can break workflows
5. **Document hooks**: Explain what they do and why

## 🚀 Git Performance and Maintenance

### Repository Optimization

```bash
# Run Git's garbage collection
git gc

# Aggressive garbage collection (slower but more thorough)
git gc --aggressive

# Clean up unreachable objects immediately
git gc --prune=now

# Check repository size
du -sh .git/

# Show largest objects in repository
git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort -k2nr | head -10
```

### Large File Management

```bash
# Find large files in history
git rev-list --objects --all | \
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
  awk '/^blob/ {print substr($0,6)}' | \
  sort -k2nr | \
  head -20

# Remove large file from history (use with caution!)
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch large-file.zip" \
  --prune-empty --tag-name-filter cat -- --all

# Alternative: BFG Repo-Cleaner (faster)
java -jar bfg.jar --delete-files large-file.zip
git reflog expire --expire=now --all && git gc --prune=now --aggressive
```

### Repository Health Checks

```bash
# Check repository integrity
git fsck

# Check for corruption
git fsck --full

# Verify connectivity and validity of objects
git fsck --connectivity-only

# Count objects and disk usage
git count-objects -v

# Show repository statistics
git log --oneline | wc -l  # Number of commits
git branch -a | wc -l      # Number of branches
git tag | wc -l            # Number of tags
```

### Configuration Optimization

```bash
# Enable parallel processing
git config --global pack.threads 0  # Use all available cores

# Increase pack size limits
git config --global pack.packSizeLimit 2g

# Enable delta compression
git config --global core.precomposeUnicode true

# Enable file system monitor (Windows/macOS)
git config --global core.fsmonitor true

# Enable partial clone for large repositories
git clone --filter=blob:none <url>  # Clone without blobs
git clone --depth 1 <url>            # Shallow clone
```

## 📋 Module 7 Exercises

### Exercise 1: Stash Management
1. Make changes to multiple files
2. Stash some changes with descriptive messages
3. Switch branches and make other changes
4. Apply stashes selectively
5. Practice stash branching

### Exercise 2: Cherry-Pick Practice
1. Create two branches with different commits
2. Cherry-pick specific commits between branches
3. Handle cherry-pick conflicts
4. Practice cherry-picking commit ranges

### Exercise 3: Interactive Rebase
1. Create a branch with messy commit history
2. Use interactive rebase to clean it up:
   - Squash related commits
   - Reorder commits logically
   - Edit commit messages
   - Remove unnecessary commits

### Exercise 4: Git Hooks Setup
1. Create a pre-commit hook that runs linting
2. Set up commit message validation
3. Create a post-commit notification hook
4. Share hooks with your team

### Exercise 5: Repository Maintenance
1. Analyze your repository size and health
2. Run garbage collection and optimization
3. Identify and handle large files
4. Set up performance configurations

## 🔧 Troubleshooting Advanced Commands

### Stash Issues
```bash
# Stash conflicts when applying
git stash pop
# Resolve conflicts, then:
git add .
git stash drop  # Remove the stash

# Can't switch branches due to stash
git stash push -u  # Include untracked files
```

### Cherry-Pick Problems
```bash
# Cherry-pick creates empty commit
git cherry-pick --allow-empty abc123

# Cherry-pick fails due to merge commit
git cherry-pick -m 1 abc123  # Choose parent 1
```

### Rebase Recovery
```bash
# Rebase went wrong
git rebase --abort  # Cancel ongoing rebase

# Lost commits after rebase
git reflog  # Find lost commits
git checkout -b recovery lost-commit-hash
```

### Hook Issues
```bash
# Hook not executing
chmod +x .git/hooks/hook-name  # Make executable

# Hook blocking commits
git commit --no-verify  # Skip hooks temporarily
```

## 💡 Advanced Git Tips

### Productivity Aliases
```bash
# Add useful aliases
git config --global alias.undo 'reset --soft HEAD~1'
git config --global alias.amend 'commit --amend --no-edit'
git config --global alias.force 'push --force-with-lease'
git config --global alias.branches 'branch -a'
git config --global alias.tags 'tag -l'
git config --global alias.stashes 'stash list'
git config --global alias.graph 'log --graph --oneline --all'
git config --global alias.contributors 'shortlog -sn'
```

### Advanced Searching
```bash
# Search commit messages
git log --grep="bug fix" --oneline

# Search code changes
git log -S "function_name" --oneline

# Search by author
git log --author="John Doe" --since="2023-01-01"

# Search in specific file
git log -p filename.js

# Find when line was added/changed
git blame filename.js
git log -L 10,20:filename.js  # Lines 10-20
```

### Working with Submodules
```bash
# Add submodule
git submodule add https://github.com/user/repo.git libs/external

# Clone repository with submodules
git clone --recursive <url>

# Update submodules
git submodule update --init --recursive

# Pull latest changes in submodules
git submodule update --remote
```

## ✅ Module 7 Checklist

Before moving to Module 8, ensure you can:

- [ ] Use git stash effectively for temporary storage
- [ ] Cherry-pick commits selectively between branches
- [ ] Use git bisect to find problematic commits
- [ ] Perform interactive rebase to clean commit history
- [ ] Manage and clean up old branches
- [ ] Recover lost commits using reflog
- [ ] Set up and customize git hooks
- [ ] Optimize repository performance
- [ ] Troubleshoot advanced Git operations
- [ ] Use advanced Git commands confidently

---

**Next Module**: [Module 8: Semantic Versioning & Releases](../08-versioning/README.md)