# Module 10: Common Pitfalls & Solutions

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Avoid common Git mistakes that can damage team productivity
- Handle merge conflicts gracefully and prevent merge bombs
- Protect sensitive data from being committed to version control
- Recover from various Git disasters
- Optimize Git performance for large repositories

## 🚫 Avoiding Force-Pushes to Shared Branches

### Why Force-Push is Dangerous

Force-pushing rewrites history and can:
- **Overwrite teammates' work**
- **Break other developers' local repositories**
- **Cause data loss**
- **Disrupt CI/CD pipelines**
- **Create confusion and conflicts**

### Safe Alternatives to Force-Push

#### 1. Use `--force-with-lease` (Safer)

```bash
# ✅ Safer option: --force-with-lease
git push --force-with-lease origin feature-branch

# This fails if someone else has pushed since your last fetch
# Protecting against overwriting others' work
```

#### 2. Fetch and Rebase First

```bash
# ✅ Best practice: Always fetch before force-pushing
git fetch origin
git rebase origin/feature-branch
git push origin feature-branch

# Only force-push if absolutely necessary:
git push --force-with-lease origin feature-branch
```

### When Force-Push is Acceptable

```bash
# ✅ Safe to force-push:
# 1. Personal feature branches (only you are working on)
git push --force-with-lease origin feature/my-personal-work

# 2. After interactive rebase on feature branch
git rebase -i HEAD~3
git push --force-with-lease origin feature/cleanup

# 3. Fixing commit messages on unshared branches
git commit --amend -m "fix: correct typo in commit message"
git push --force-with-lease origin feature/typo-fix
```

## 🤝 Handling Merge Conflicts Gracefully

### Understanding Merge Conflicts

Conflicts occur when:
- Two branches modify the same lines
- One branch deletes a file while another modifies it
- File is moved in one branch and modified in another

### Conflict Anatomy

```bash
<<<<<<< HEAD (your current branch)
function login(username, password) {
    return authenticateUser(username, password);
}
=======
function login(email, pwd) {
    return validateCredentials(email, pwd);
}
>>>>>>> feature-branch (incoming changes)
```

### Step-by-Step Conflict Resolution

#### 1. Don't Panic

```bash
# When you see conflicts:
$ git merge feature-branch
Auto-merging src/auth.js
CONFLICT (content): Merge conflict in src/auth.js
Automatic merge failed; fix conflicts and then commit the result.

# Check status
git status
# Shows which files have conflicts
```

#### 2. Resolve Each Conflict

```bash
# Manual resolution options:

# Option 1: Take current branch version
git checkout --ours conflicted-file.js

# Option 2: Take incoming branch version
git checkout --theirs conflicted-file.js

# Option 3: Manual edit (most common)
# Edit file to combine both changes appropriately
```

#### 3. Complete the Merge

```bash
# After resolving all conflicts:
git add .
git commit -m "Merge feature-branch into main

Resolved conflicts in:
- src/auth.js: Combined function signatures
- src/utils.js: Kept both utility functions"
```

### Preventing Conflicts

#### 1. Communicate with Team

```bash
# Before major refactoring:
echo "Planning to refactor auth system this week"
echo "Please coordinate if working on auth-related files"

# Use draft PRs for early visibility
gh pr create --draft --title "WIP: Auth refactor"
```

#### 2. Keep Branches Small and Short-lived

```bash
# ✅ Good: Small, focused changes
feature/add-login-button (2 days, 15 lines)
feature/validate-email (1 day, 30 lines)

# ❌ Avoid: Large, long-running branches
feature/complete-redesign (3 weeks, 500+ lines)
```

## 💣 Avoiding Merge Bombs

### What are Merge Bombs?

Merge bombs occur when:
- Large branches with many changes merge at once
- Multiple large features merge simultaneously
- Long-running branches finally integrate
- Inadequate testing before merging

### Prevention Strategies

#### 1. Feature Flags and Incremental Delivery

```javascript
// Instead of big-bang release, use feature flags
function renderUserInterface() {
  if (featureFlags.newDesign && user.isInBetaGroup) {
    return <NewDesign />;
  }
  return <CurrentDesign />;
}

// Gradual rollout
const rolloutPercentage = {
  development: 100,
  staging: 50,
  production: 10  // Start with 10% of users
};
```

#### 2. Break Large Features into Smaller PRs

```bash
# ❌ Avoid: Monolithic PR
"Add complete user management system" (500+ files changed)

# ✅ Better: Break into smaller PRs
"Add user model and basic CRUD operations" (15 files)
"Add user authentication endpoints" (8 files)
"Add user profile UI components" (12 files)
"Add user permissions system" (10 files)
"Integrate user management with existing features" (20 files)
```

## 🔒 Keeping Secrets Out of Version Control

### Common Secret Leaks

```bash
# ❌ Common mistakes:
# 1. Environment files
.env
config.prod.json

# 2. API keys in code
const API_KEY = "sk_live_abcd1234...";

# 3. Database credentials
connection_string = "mongodb://admin:password123@..."

# 4. Private keys
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC...
```

### Prevention Strategies

#### 1. Comprehensive .gitignore

```bash
# .gitignore for secrets
# Environment variables
.env
.env.local
.env.*.local
.environment

# Configuration files
config.json
config.prod.json
settings.ini

# Key files
*.key
*.pem
*.p12
*.pfx
*.crt

# IDE and OS files
.DS_Store
.vscode/settings.json
.idea/

# Logs that might contain secrets
*.log
logs/

# Package manager
node_modules/
.npm

# Build artifacts
dist/
build/
*.min.js
```

#### 2. Environment Variable Patterns

```javascript
// ✅ Good: Use environment variables
const config = {
  apiKey: process.env.API_KEY,
  dbUrl: process.env.DATABASE_URL,
  jwtSecret: process.env.JWT_SECRET
};

// ✅ Good: Validate required secrets
function validateEnvironment() {
  const required = ['API_KEY', 'DATABASE_URL', 'JWT_SECRET'];
  const missing = required.filter(key => !process.env[key]);
  
  if (missing.length > 0) {
    throw new Error(`Missing required environment variables: ${missing.join(', ')}`);
  }
}
```

#### 3. Pre-commit Hooks for Secret Detection

```bash
#!/bin/sh
# .git/hooks/pre-commit
# Secret detection hook

echo "🔍 Scanning for secrets..."

# Check for common secret patterns
if git diff --cached --name-only | xargs grep -l -i -E "(api_key|password|secret|token|key)\\\\s*=\\\\s*['\"][^'\"]{10,}"; then
    echo "❌ Potential secrets detected in staged files!"
    echo "Please remove secrets and use environment variables instead."
    exit 1
fi

echo "✅ No secrets detected."
```

### Secret Recovery (If Leaked)

#### 1. Immediate Response

```bash
# 1. Rotate/revoke the compromised secrets immediately
# 2. Remove from latest commit if just committed
git reset --soft HEAD~1
# Edit files to remove secrets
git add .
git commit -m "Remove secrets from repository"

# 3. If already pushed, force-push (if safe)
git push --force-with-lease origin branch-name
```

#### 2. Remove from History (Nuclear Option)

```bash
# ⚠️ WARNING: This rewrites history!
# Use BFG Repo Cleaner (recommended)
java -jar bfg.jar --replace-text secrets.txt
git reflog expire --expire=now --all
git gc --prune=now --aggressive
```

## 🛠️ Recovery Techniques

### Common Recovery Scenarios

#### 1. Accidentally Deleted Branch

```bash
# Find the deleted branch in reflog
git reflog --all | grep "branch-name"

# Recreate branch from last known commit
git checkout -b recovered-branch abc123
```

#### 2. Lost Commits After Reset

```bash
# Find lost commits
git reflog
# Look for: abc123 HEAD@{1}: commit: Important feature

# Recover commits
git checkout abc123
git checkout -b recovery-branch

# Or cherry-pick specific commits
git checkout main
git cherry-pick abc123
```

#### 3. Wrong Branch Merged

```bash
# Find the merge commit
git log --oneline --merges -10

# Revert the merge
git revert -m 1 merge-commit-hash

# Or reset to before merge (if safe)
git reset --hard HEAD~1
```

## ⚡ Performance Optimization

### Large Repository Issues

```bash
# Check repository size
du -sh .git/
git count-objects -vH

# Find large files
git rev-list --objects --all | \\
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \\
  sed -n 's/^blob //p' | \\
  sort -k2nr | \\
  head -20
```

### Optimization Techniques

#### 1. Garbage Collection

```bash
# Regular cleanup
git gc

# Aggressive cleanup (slower but more thorough)
git gc --aggressive --prune=now

# Auto garbage collection settings
git config gc.auto 6700
git config gc.autopacklimit 50
```

#### 2. Shallow Clones

```bash
# Clone only recent history
git clone --depth 50 https://github.com/user/repo.git

# Clone specific branch only
git clone --single-branch --branch main https://github.com/user/repo.git

# Partial clone (Git 2.19+)
git clone --filter=blob:none https://github.com/user/repo.git
```

#### 3. LFS for Large Files

```bash
# Install Git LFS
git lfs install

# Track large file types
git lfs track "*.psd"
git lfs track "*.zip"
git lfs track "*.mp4"

# Add .gitattributes
git add .gitattributes
git commit -m "Add LFS tracking"
```

## 📋 Module 10 Exercises

### Exercise 1: Conflict Resolution Practice
1. Create two branches with conflicting changes
2. Practice different merge conflict resolution strategies
3. Use merge tools to resolve conflicts
4. Practice aborting and retrying merges

### Exercise 2: Secret Detection
1. Set up pre-commit hooks for secret detection
2. Practice removing secrets from repositories
3. Configure proper .gitignore patterns
4. Test secret scanning tools

### Exercise 3: Recovery Scenarios
1. Practice recovering deleted branches
2. Simulate lost commits and recover them
3. Practice reverting problematic merges
4. Use reflog for various recovery scenarios

### Exercise 4: Performance Optimization
1. Analyze repository size and performance
2. Practice garbage collection
3. Set up Git LFS for large files
4. Configure performance optimizations

## 🔧 Troubleshooting Guide

### Force-Push Issues

```bash
# Teammate's work overwritten
# 1. Check reflog on affected branch
git reflog origin/branch-name

# 2. Recover lost commits
git checkout -b recovery origin/branch-name@{1}

# 3. Merge recovered work
git checkout main
git merge recovery
```

### Merge Conflict Hell

```bash
# Too many conflicts to resolve
# 1. Abort current merge
git merge --abort

# 2. Try rebase instead
git rebase main

# 3. Or break down the merge
git cherry-pick commit1
git cherry-pick commit2
# Resolve conflicts one commit at a time
```

### Performance Issues

```bash
# Slow Git operations
# 1. Check repository health
git fsck

# 2. Clean up repository
git gc --aggressive

# 3. Check for large files
git rev-list --objects --all | git cat-file --batch-check='%(objectsize) %(rest)' | sort -nr | head -10

# 4. Consider using Git LFS
git lfs migrate import --include="*.zip,*.tar.gz"
```

## 💡 Prevention Best Practices

### Team Guidelines

```markdown
# Git Safety Guidelines

## Never Do
- Force-push to shared branches (main, develop)
- Commit secrets or sensitive data
- Make large commits without breaking them down
- Ignore merge conflicts and "resolve" by choosing one side

## Always Do
- Use --force-with-lease instead of --force
- Review changes before committing
- Test changes before pushing
- Communicate about large refactoring work
- Use feature flags for experimental features

## When In Doubt
- Ask team members before force-pushing
- Create backup branches before risky operations
- Use git stash to save work before switching contexts
- Check git status frequently
```

### Automation for Safety

```yaml
# .github/workflows/safety-checks.yml
name: Safety Checks

on: [push, pull_request]

jobs:
  secret-scan:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Run secret scan
      run: |
        # Install and run secret scanning tool
        npm install -g detect-secrets
        detect-secrets scan --all-files
  
  large-file-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Check for large files
      run: |
        # Check for files larger than 50MB
        find . -type f -size +50M -not -path "./.git/*" -exec ls -lh {} \\;
```

## ✅ Module 10 Checklist

Before moving to Module 11, ensure you can:

- [ ] Understand when and how to safely use force-push
- [ ] Resolve merge conflicts systematically
- [ ] Prevent and handle merge bombs
- [ ] Keep secrets out of version control
- [ ] Recover from common Git disasters
- [ ] Optimize Git performance for large repositories
- [ ] Set up safety measures and automation
- [ ] Troubleshoot common Git issues
- [ ] Follow Git safety best practices
- [ ] Help team members avoid common pitfalls

---

**Next Module**: [Module 11: Onboarding & Documentation](../11-onboarding/README.md)
