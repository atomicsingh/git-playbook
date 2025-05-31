# Module 6: GitHub Features

## 🎯 Learning Objectives

By the end of this module, you will be able to:
- Use GitHub Issues effectively for project management
- Organize work with GitHub Projects and Boards
- Implement milestones and labels for better organization
- Create and manage releases with proper tagging
- Get started with GitHub Actions for automation

## 🎫 GitHub Issues

### What are GitHub Issues?

GitHub Issues are a powerful project management tool that helps you:
- **Track bugs** and feature requests
- **Plan work** and organize tasks
- **Collaborate** with team members
- **Document decisions** and discussions
- **Link work** to code changes

### Creating Effective Issues

#### Issue Anatomy
```markdown
# Title: Clear, descriptive summary
**Bug**: Login form validation fails on mobile devices
**Feature**: Add dark mode toggle to user settings
**Task**: Update documentation for API v2

# Body: Detailed description
## Description
Detailed explanation of the issue or feature

## Steps to Reproduce (for bugs)
1. Go to login page on mobile
2. Enter invalid email
3. No validation message appears

## Expected Behavior
Validation message should appear

## Actual Behavior
No feedback provided to user

## Acceptance Criteria (for features)
- [ ] Toggle switch in user settings
- [ ] Persists across sessions
- [ ] Applies to all pages
```

#### Issue Templates

Create organized issue templates in `.github/ISSUE_TEMPLATE/`:

**Bug Report Template:**
```yaml
---
name: 🐛 Bug Report
about: Create a report to help us improve
title: '[BUG] '
labels: ['bug', 'needs-triage']
assignees: ''
---

## 🐛 Bug Description
A clear and concise description of the bug.

## 🔄 Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

## ✅ Expected Behavior
What should happen.

## ❌ Actual Behavior
What actually happens.

## 🖼️ Screenshots
If applicable, add screenshots.

## 🌍 Environment
- OS: [e.g. iOS, Windows, macOS]
- Browser: [e.g. chrome, safari]
- Version: [e.g. 22]
- Device: [e.g. iPhone 12, Desktop]
```

**Feature Request Template:**
```yaml
---
name: ✨ Feature Request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: ['enhancement', 'needs-discussion']
assignees: ''
---

## 🎯 Feature Description
A clear and concise description of what you want to happen.

## 🤔 Problem Statement
What problem does this solve? What is the current limitation?

## 💡 Proposed Solution
Describe the solution you'd like.

## 🔄 Alternatives Considered
Describe any alternative solutions or features you've considered.

## ✅ Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## 📋 Additional Context
Add any other context, mockups, or examples.
```

### Advanced Issue Features

#### Using Issue Forms (GitHub's new feature)
```yaml
# .github/ISSUE_TEMPLATE/bug_report.yml
name: Bug Report
description: File a bug report
title: "[Bug]: "
labels: ["bug", "triage"]
assignees:
  - octocat
body:
  - type: markdown
    attributes:
      value: |
        Thanks for taking the time to fill out this bug report!
  - type: input
    id: contact
    attributes:
      label: Contact Details
      description: How can we get in touch with you if we need more info?
      placeholder: ex. email@example.com
    validations:
      required: false
  - type: textarea
    id: what-happened
    attributes:
      label: What happened?
      description: Also tell us, what did you expect to happen?
      placeholder: Tell us what you see!
    validations:
      required: true
  - type: dropdown
    id: version
    attributes:
      label: Version
      description: What version of our software are you running?
      options:
        - 1.0.2 (Default)
        - 1.0.3 (Beta)
        - 1.0.4 (Alpha)
    validations:
      required: true
```

## 🏷️ Labels and Organization

### Essential Label Categories

#### Type Labels
```
🐛 bug          - Something isn't working
✨ enhancement  - New feature or request
📝 documentation- Improvements or additions to docs
❓ question     - Further information is requested
🔧 maintenance  - Code maintenance and refactoring
🚨 security     - Security-related issues
```

#### Priority Labels
```
🔴 critical     - Requires immediate attention
🟠 high         - Should be addressed soon
🟡 medium       - Normal priority
🟢 low          - Nice to have
```

#### Status Labels
```
🏁 ready        - Ready to be worked on
🚧 in-progress  - Currently being worked on
⏳ blocked      - Cannot proceed due to dependency
✅ completed    - Work is done
❌ wontfix      - Will not be addressed
🔄 duplicate    - Duplicate of another issue
```

#### Size Labels (for estimation)
```
size/XS  - Extra small (1-2 hours)
size/S   - Small (half day)
size/M   - Medium (1-2 days)
size/L   - Large (3-5 days)
size/XL  - Extra large (1+ weeks)
```

### Label Management

```bash
# Using GitHub CLI to manage labels
gh label create "bug" --color "d73a4a" --description "Something isn't working"
gh label create "enhancement" --color "a2eeef" --description "New feature or request"
gh label create "documentation" --color "0075ca" --description "Improvements to docs"

# List all labels
gh label list

# Delete label
gh label delete "wontfix"
```

## 📋 GitHub Projects and Boards

### GitHub Projects (Classic)

#### Setting Up a Project Board
1. Go to repository → Projects → New Project
2. Choose template:
   - **Basic Kanban**: To do, In progress, Done
   - **Automated Kanban**: Auto-moves cards based on PR status
   - **Bug Triage**: For managing bug reports

#### Kanban Board Columns
```
📝 Backlog       - Ideas and future work
📋 To Do         - Ready to be worked on
🚧 In Progress   - Currently being worked on
👀 Review        - Waiting for code review
🧪 Testing       - Ready for testing
✅ Done          - Completed work
```

#### Automation Rules
```yaml
# Automatically move cards
To Do → In Progress: When PR is opened
In Progress → Review: When PR is ready for review
Review → Testing: When PR is approved
Testing → Done: When PR is merged
```

### GitHub Projects (Beta/New)

The new GitHub Projects offers more powerful features:

#### Creating a Project
```bash
# Using GitHub CLI
gh project create --title "Product Roadmap" --body "Our product development roadmap"
```

#### Custom Fields
- **Status**: Todo, In Progress, Done
- **Priority**: High, Medium, Low
- **Size**: S, M, L, XL
- **Sprint**: Sprint 1, Sprint 2, etc.
- **Assignee**: Team member
- **Due Date**: Target completion

#### Views
- **Board View**: Traditional Kanban
- **Table View**: Spreadsheet-like
- **Roadmap View**: Timeline visualization

## 🎯 Milestones

### What are Milestones?

Milestones represent significant points in your project:
- **Releases**: v1.0, v2.0, etc.
- **Sprints**: Sprint 1, Sprint 2
- **Deadlines**: Q1 Goals, Beta Launch
- **Features**: User Authentication, Payment System

### Creating Effective Milestones

```markdown
# Milestone: v1.0 Release
**Due Date**: March 15, 2024
**Description**: 
First major release including core features:
- User authentication
- Basic CRUD operations
- Responsive design
- Basic API

**Success Criteria**:
- All P0 bugs resolved
- Performance benchmarks met
- Documentation complete
- Security audit passed
```

### Managing Milestones

```bash
# Using GitHub CLI
gh milestone create "v1.0 Release" --due-date "2024-03-15" --description "First major release"

# List milestones
gh milestone list

# Close milestone
gh milestone close "v1.0 Release"
```

## 🏷️ Tags and Releases

### Understanding Tags

Tags are references to specific points in Git history:
- **Lightweight tags**: Simple pointer to a commit
- **Annotated tags**: Full objects with metadata

```bash
# Create lightweight tag
git tag v1.0.0

# Create annotated tag (recommended)
git tag -a v1.0.0 -m "Release version 1.0.0"

# List tags
git tag
git tag -l "v1.*"

# Push tags to remote
git push origin v1.0.0
git push origin --tags

# Delete tag
git tag -d v1.0.0
git push origin --delete v1.0.0
```

### Semantic Versioning for Tags

Follow semantic versioning (SemVer):
```
MAJOR.MINOR.PATCH

v1.0.0 - Initial release
v1.0.1 - Patch release (bug fixes)
v1.1.0 - Minor release (new features, backward compatible)
v2.0.0 - Major release (breaking changes)
```

**Examples:**
```bash
v1.0.0     # Major release
v1.1.0     # Added new features
v1.1.1     # Bug fix
v1.2.0     # More new features
v2.0.0     # Breaking changes
v2.0.1     # Bug fix for v2.0.0
```

### Creating GitHub Releases

#### Manual Release Creation
1. Go to repository → Releases → Create a new release
2. Choose or create a tag
3. Write release notes
4. Attach binaries (if applicable)
5. Mark as pre-release (if beta/alpha)

#### Release Notes Template
```markdown
# Release v1.2.0

## 🎉 New Features
- Added dark mode toggle (#123)
- Implemented user profiles (#145)
- Added export functionality (#167)

## 🐛 Bug Fixes
- Fixed login validation on mobile (#134)
- Resolved memory leak in dashboard (#156)
- Fixed timezone display issues (#178)

## 🔧 Improvements
- Improved page load performance by 25%
- Updated dependencies to latest versions
- Enhanced error messaging

## 🚨 Breaking Changes
- API endpoint `/users` now requires authentication
- Removed deprecated `legacy_mode` parameter

## 📋 Migration Guide
For users upgrading from v1.1.x:
1. Update API calls to include authentication
2. Remove `legacy_mode` from configurations
3. Clear browser cache after update

## 📊 Statistics
- 15 commits since v1.1.0
- 8 contributors
- 12 issues closed

**Full Changelog**: https://github.com/owner/repo/compare/v1.1.0...v1.2.0
```

#### Automated Release Creation
```bash
# Using GitHub CLI
gh release create v1.2.0 --title "Release v1.2.0" --notes-file RELEASE_NOTES.md

# Create pre-release
gh release create v1.2.0-beta --prerelease --title "Beta Release v1.2.0" 

# Upload assets
gh release upload v1.2.0 dist/app.zip dist/app.tar.gz
```

## 🤖 GitHub Actions Introduction

### What are GitHub Actions?

GitHub Actions is a CI/CD platform that allows you to:
- **Automate workflows** triggered by repository events
- **Run tests** on multiple environments
- **Deploy applications** automatically
- **Maintain repositories** with scheduled tasks

### Basic Workflow Structure

```yaml
# .github/workflows/ci.yml
name: Continuous Integration

# When to run this workflow
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

# Jobs to run
jobs:
  test:
    # Operating system
    runs-on: ubuntu-latest
    
    # Steps to execute
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        
    - name: Install dependencies
      run: npm ci
      
    - name: Run tests
      run: npm test
      
    - name: Run linting
      run: npm run lint
```

### Common Workflow Examples

#### 1. Basic CI/CD Pipeline
```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [16, 18, 20]
    
    steps:
    - uses: actions/checkout@v3
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v3
      with:
        node-version: ${{ matrix.node-version }}
    - run: npm ci
    - run: npm test
    
  deploy:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
    - uses: actions/checkout@v3
    - name: Deploy to production
      run: |
        echo "Deploying to production..."
        # Add deployment commands here
```

#### 2. Automated Release
```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Create Release
      uses: actions/create-release@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        tag_name: ${{ github.ref }}
        release_name: Release ${{ github.ref }}
        draft: false
        prerelease: false
```

#### 3. Issue and PR Automation
```yaml
name: Issue Management

on:
  issues:
    types: [opened]
  pull_request:
    types: [opened]

jobs:
  welcome:
    runs-on: ubuntu-latest
    steps:
    - name: Welcome new contributors
      uses: actions/github-script@v6
      with:
        script: |
          const message = `Thanks for opening this ${context.eventName}! 🎉
          
          Our team will review it soon. Please make sure you've:
          - [ ] Followed our contributing guidelines
          - [ ] Added appropriate labels
          - [ ] Provided enough context
          `;
          
          if (context.eventName === 'issues') {
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: message
            });
          }
```

### GitHub Actions Marketplace

Explore pre-built actions at [github.com/marketplace](https://github.com/marketplace):

**Popular Actions:**
- `actions/checkout` - Check out repository code
- `actions/setup-node` - Setup Node.js environment
- `actions/upload-artifact` - Upload build artifacts
- `docker/build-push-action` - Build and push Docker images
- `peaceiris/actions-gh-pages` - Deploy to GitHub Pages

### Secrets Management

```yaml
# Using secrets in workflows
steps:
- name: Deploy
  env:
    API_KEY: ${{ secrets.API_KEY }}
    DATABASE_URL: ${{ secrets.DATABASE_URL }}
  run: |
    echo "Deploying with API key..."
    # Deployment commands
```

**Setting up secrets:**
1. Go to repository → Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add name and value
4. Use in workflows with `${{ secrets.SECRET_NAME }}`

## 📊 Advanced GitHub Features

### GitHub Pages

Host static websites directly from your repository:

```yaml
# .github/workflows/deploy-pages.yml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        
    - name: Install and build
      run: |
        npm ci
        npm run build
        
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./dist
```

### GitHub Packages

Host and manage packages:

```yaml
# Publish npm package
name: Publish Package

on:
  release:
    types: [published]

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-node@v3
      with:
        node-version: '18'
        registry-url: 'https://npm.pkg.github.com'
        scope: '@your-username'
    - run: npm ci
    - run: npm publish
      env:
        NODE_AUTH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Security Features

#### Dependabot
Automatic dependency updates:

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    reviewers:
      - "your-username"
    assignees:
      - "your-username"
```

#### Security Advisories
1. Go to Security → Advisories
2. Create advisory for vulnerabilities
3. Request CVE if needed
4. Coordinate disclosure

#### Code Scanning
```yaml
# .github/workflows/codeql.yml
name: "CodeQL"

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 0 * * 0'

jobs:
  analyze:
    name: Analyze
    runs-on: ubuntu-latest
    strategy:
      matrix:
        language: [ 'javascript' ]
    
    steps:
    - name: Checkout repository
      uses: actions/checkout@v3
      
    - name: Initialize CodeQL
      uses: github/codeql-action/init@v2
      with:
        languages: ${{ matrix.language }}
        
    - name: Perform CodeQL Analysis
      uses: github/codeql-action/analyze@v2
```

## 📋 Module 6 Exercises

### Exercise 1: Set Up Project Management
1. Create issue templates for your repository
2. Set up a project board with appropriate columns
3. Create and organize labels
4. Add milestones for upcoming releases

### Exercise 2: Practice with Issues
1. Create several issues using your templates
2. Assign labels, milestones, and assignees
3. Link issues to pull requests
4. Close issues through commit messages

### Exercise 3: Release Management
1. Create annotated tags for versions
2. Write comprehensive release notes
3. Create a GitHub release
4. Set up automated changelog generation

### Exercise 4: Basic GitHub Actions
1. Create a simple CI workflow
2. Add automated testing
3. Set up deployment pipeline
4. Experiment with different triggers

## 🔧 Troubleshooting GitHub Features

### Issues Not Linking to PRs
- Check linking syntax in PR description
- Ensure issue numbers are correct
- Verify repository permissions

### Actions Workflow Failing
```bash
# Common debugging steps
- Check workflow syntax with yamllint
- Verify secret names and values
- Check runner operating system compatibility
- Review action versions for breaking changes
```

### Project Board Not Updating
- Check automation rules configuration
- Verify PR/issue labels match rules
- Ensure proper permissions are set

### Release Creation Issues
```bash
# Common issues
- Tag doesn't exist: git tag -a v1.0.0 -m "Release" && git push --tags
- Permission denied: Check repository write access
- Missing release notes: Add description or notes file
```

## 💡 Best Practices

### Issue Management
- Use templates for consistency
- Label issues promptly
- Keep descriptions clear and actionable
- Link related issues and PRs
- Close issues when work is complete

### Project Organization
- Regular board maintenance
- Clear column definitions
- Consistent automation rules
- Regular milestone reviews

### Release Management
- Follow semantic versioning
- Write detailed release notes
- Test releases before publishing
- Keep changelog updated
- Tag releases consistently

### GitHub Actions
- Start simple and iterate
- Use official actions when possible
- Secure secrets properly
- Test workflows in feature branches
- Monitor action usage and costs

## ✅ Module 6 Checklist

Before moving to Module 7, ensure you can:

- [ ] Create and manage GitHub Issues effectively
- [ ] Set up and use project boards for organization
- [ ] Implement a labeling and milestone system
- [ ] Create releases with proper tagging and notes
- [ ] Write basic GitHub Actions workflows
- [ ] Use GitHub's project management features
- [ ] Understand GitHub's security and automation features
- [ ] Troubleshoot common GitHub feature issues

---

**Next Module**: [Module 7: Advanced Git Commands](../07-advanced-commands/README.md)