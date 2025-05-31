# Module 9: Team Best Practices

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Implement effective commit message conventions
- Create atomic commits that enhance project history
- Maintain a clean and deployable main branch
- Establish productive team workflows
- Use feature flags and branch naming conventions

## ✍️ Commit Message Conventions

### Why Commit Messages Matter

Good commit messages:
- **Communicate intent** to future developers
- **Enable automation** (changelog generation, releases)
- **Improve debugging** (git bisect, git blame)
- **Facilitate code reviews**
- **Document project evolution**

### Conventional Commits Standard

```bash
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### Commit Types

```bash
feat:     New feature for the user
fix:      Bug fix for the user
docs:     Documentation changes
style:    Code style changes (formatting, missing semi-colons, etc)
refactor: Code change that neither fixes a bug nor adds a feature
perf:     Performance improvements
test:     Adding missing tests or correcting existing tests
chore:    Changes to build process or auxiliary tools
ci:       Changes to CI configuration files and scripts
build:    Changes that affect the build system or dependencies
revert:   Reverts a previous commit
```

#### Examples of Good Commit Messages

```bash
# ✅ Good commit messages
feat(auth): add OAuth2 integration with Google
fix(ui): resolve button alignment on mobile devices
docs(api): update authentication endpoint documentation
refactor(db): optimize user query performance
test(auth): add unit tests for login validation
chore(deps): update lodash to version 4.17.21

# With body and footer
feat(payment): add Stripe payment integration

Integrate Stripe payment processing to handle:
- Credit card payments
- Subscription billing
- Webhook handling for payment events

Closes #123
Breaking change: Payment API endpoints have changed
```

## ⚛️ Atomic Commits

### What are Atomic Commits?

Atomic commits are:
- **Self-contained**: Each commit represents one logical change
- **Complete**: The codebase works after the commit
- **Focused**: Only related changes are included
- **Reversible**: Can be safely reverted without side effects

### Creating Atomic Commits

```bash
# Stage specific files
git add src/auth/register.js
git commit -m "feat(auth): add user registration logic"

# Stage parts of files
git add -p src/auth/auth.js
# Select hunks to stage, commit related changes together

# Stage and commit in one go
git commit -am "fix(ui): resolve button styling issues"
```

## 🌿 Keeping Main Branch Clean

### Main Branch Principles

1. **Always deployable**: Main should be production-ready
2. **Never broken**: All tests pass
3. **Linear history**: Prefer merge commits or rebase
4. **Protected**: Use branch protection rules
5. **Up-to-date**: Regular integration of changes

### Branch Protection Rules

Set up in GitHub: Settings → Branches → Add rule

```yaml
# Recommended protection rules:
✅ Require pull request reviews before merging
✅ Dismiss stale reviews when new commits are pushed
✅ Require review from code owners
✅ Require status checks to pass before merging
✅ Require branches to be up to date before merging
✅ Include administrators (enforce for everyone)
✅ Restrict pushes that create files larger than 100MB
```

## 🔄 Pull Regularly, Push Often

### The Golden Rule

**"Pull early, pull often, push frequently"**

### Daily Workflow Best Practices

```bash
# Start of day routine:
git checkout main
git pull origin main
git checkout feature/my-feature
git rebase main  # Keep feature branch up-to-date

# During development:
# Every 2-3 hours or before major changes:
git fetch origin
git rebase origin/main

# End of day routine:
git add .
git commit -m "feat(feature): progress on user dashboard"
git push origin feature/my-feature
```

## 🚩 Feature Flags vs Long-Running Branches

### Feature Flags Solution

```javascript
// Feature flag implementation
const featureFlags = {
  newUserDashboard: process.env.FEATURE_NEW_DASHBOARD === 'true',
  enhancedSearch: process.env.FEATURE_ENHANCED_SEARCH === 'true'
};

// Usage in code
function renderDashboard() {
  if (featureFlags.newUserDashboard) {
    return <NewDashboard />;
  }
  return <LegacyDashboard />;
}
```

## 📁 Branch Naming Conventions

### Consistent Naming Patterns

```bash
# Type-based naming:
feature/user-authentication
feature/payment-integration
bugfix/login-validation
hotfix/security-patch
release/v1.2.0
experiment/new-ui-framework

# Issue-based naming:
feature/123-user-profiles
bugfix/456-memory-leak
hotfix/789-sql-injection

# User-based naming (for long-running work):
john/refactor-database
sarah/performance-optimization
```

### Naming Rules

1. **Use lowercase**: `feature/user-auth` not `Feature/User-Auth`
2. **Use hyphens**: `feature/user-auth` not `feature/user_auth`
3. **Be descriptive**: `fix/login-error` not `fix/bug`
4. **Keep reasonable length**: `feature/user-authentication`
5. **Include issue numbers**: `feature/123-user-profiles`

## 👥 Team Collaboration Guidelines

### Code Review Standards

```markdown
## Code Review Checklist

### Functionality
- [ ] Code does what it's supposed to do
- [ ] Edge cases are handled
- [ ] Error handling is appropriate
- [ ] Performance considerations addressed

### Code Quality
- [ ] Code is readable and well-commented
- [ ] Functions/classes have single responsibility
- [ ] No code duplication
- [ ] Follows team coding standards

### Testing
- [ ] Adequate test coverage
- [ ] Tests are meaningful and not just for coverage
- [ ] Tests pass locally and in CI

### Security
- [ ] No sensitive data in code
- [ ] Input validation where needed
- [ ] Authentication/authorization appropriate
```

### Team Workflow Agreements

```markdown
# Team Git Workflow Agreement

## Branching
- Create feature branches from main
- Use descriptive branch names with prefixes
- Keep branches short-lived (< 1 week)
- Delete branches after merging

## Commits
- Use conventional commit messages
- Make atomic commits
- Squash "fix typo" type commits before merging
- Test changes before committing

## Pull Requests
- Open draft PRs for early feedback
- Request specific reviewers
- Address all review comments
- Update PR description as changes are made

## Code Review
- Review PRs within 24 hours
- Be constructive and specific in feedback
- Test the changes locally when needed
- Approve only when confident in the changes
```

## 📋 Module 9 Exercises

### Exercise 1: Commit Message Practice
1. Review your recent commits
2. Rewrite poor commit messages using conventional format
3. Practice writing descriptive commit messages
4. Set up commit message template

### Exercise 2: Atomic Commits
1. Make a large change affecting multiple areas
2. Break it into atomic commits
3. Practice staging changes selectively
4. Use interactive staging

### Exercise 3: Team Workflow
1. Set up branch protection rules
2. Create a team workflow agreement
3. Practice the PR review process
4. Implement feature flags in a project

### Exercise 4: Branch Management
1. Establish branch naming conventions
2. Set up automated branch cleanup
3. Practice frequent pulling and rebasing
4. Handle merge conflicts effectively

## 🔧 Troubleshooting Team Issues

### Common Problems

```bash
# Merge conflicts from infrequent pulling
git pull --rebase origin main  # Rebase instead of merge
git mergetool                  # Use merge tool for conflicts

# Accidental commits to main
git log --oneline -5           # Find the commits
git reset --soft HEAD~2        # Move commits to staging
git checkout -b feature/fix    # Create feature branch
git commit -m "Move commits to feature branch"

# Force push conflicts
git push --force-with-lease origin feature-branch  # Safer than --force
```

## 💡 Advanced Team Practices

### Git Aliases for Teams

```bash
# Team-focused aliases
git config --global alias.contributors 'shortlog -sn'
git config --global alias.activity 'log --since="1 month ago" --oneline --all'
git config --global alias.standup 'log --since="yesterday" --author="$USER" --oneline'
git config --global alias.review 'log --oneline -10'

# Workflow aliases
git config --global alias.sync '!git checkout main && git pull origin main'
git config --global alias.feature '!f() { git sync && git checkout -b feature/$1; }; f'
```

### Pair Programming with Git

```bash
# Co-author commits when pair programming
git commit -m "feat(auth): implement OAuth login

Co-authored-by: Jane Doe <jane@example.com>
Co-authored-by: John Smith <john@example.com>"

# Switch driver during session
git add .
git commit -m "WIP: auth progress" # Temporary commit
git push origin feature/auth
# Other person pulls and continues
```

### Code Review Culture

```markdown
## Creating a Positive Review Culture

### For Authors
- Self-review before requesting review
- Provide context in PR description
- Be responsive to feedback
- Don't take feedback personally

### For Reviewers
- Assume positive intent
- Explain the "why" behind suggestions
- Recognize good code
- Focus on learning opportunities

### For Teams
- Establish review guidelines
- Regular retrospectives on review process
- Share knowledge through reviews
- Balance thorough review with velocity
```

## ✅ Module 9 Checklist

Before moving to Module 10, ensure you can:

- [ ] Write effective conventional commit messages
- [ ] Create atomic, focused commits
- [ ] Maintain a clean and deployable main branch
- [ ] Implement team workflow agreements
- [ ] Use feature flags effectively
- [ ] Follow consistent branch naming conventions
- [ ] Conduct constructive code reviews
- [ ] Handle team collaboration challenges
- [ ] Set up automated workflow tools
- [ ] Establish positive team culture around Git

---

**Next Module**: [Module 10: Common Pitfalls & Solutions](../10-pitfalls/README.md)
