# Git Templates & Examples

This directory contains templates and examples to standardize Git workflows in your team or organization.

## 🗂️ Available Templates

### 📄 GitHub Templates

- [Issue Template - Bug Report](./github/issue_template_bug.md)
- [Issue Template - Feature Request](./github/issue_template_feature.md)
- [Pull Request Template](./github/pull_request_template.md)
- [GitHub Actions Workflow](./github/workflow_ci.yml)
- [CODEOWNERS Template](./github/CODEOWNERS)

### 🛠️ Git Configuration

- [.gitignore Templates](./gitignore/)
- [Git Attributes Template](./gitattributes/gitattributes)
- [Global Git Configuration](./git-config/gitconfig)

### 🪝 Git Hooks

- [Pre-commit Hook - Code Quality](./hooks/pre-commit)
- [Commit-msg Hook - Message Format](./hooks/commit-msg)
- [Pre-push Hook - Tests](./hooks/pre-push)
- [Setup Script for Hooks](./hooks/setup.sh)

### 📝 Documentation Templates

- [README Template](./docs/README_template.md)
- [CONTRIBUTING Template](./docs/CONTRIBUTING_template.md)
- [Git Workflow Guide Template](./docs/workflow_guide_template.md)
- [Release Process Template](./docs/release_process_template.md)

## 🚀 How to Use

1. **Copy the template** you need to your repository
2. **Customize** it for your project's specific needs
3. **Document** any changes in your team's playbook

### Example Usage

```bash
# Copy issue templates to your repository
mkdir -p .github/ISSUE_TEMPLATE
cp templates/github/issue_template_bug.md .github/ISSUE_TEMPLATE/bug_report.md
cp templates/github/issue_template_feature.md .github/ISSUE_TEMPLATE/feature_request.md

# Copy PR template
cp templates/github/pull_request_template.md .github/pull_request_template.md

# Set up Git hooks
mkdir -p .git/hooks
cp templates/hooks/pre-commit .git/hooks/
cp templates/hooks/commit-msg .git/hooks/
chmod +x .git/hooks/pre-commit .git/hooks/commit-msg
```

## 🔧 Customization

These templates provide a solid starting point, but you should customize them to fit your team's specific needs. Consider:

- Adjusting code style rules to match your project
- Modifying commit message patterns for your conventions
- Updating CI/CD workflows for your build process
- Tailoring documentation templates to your team culture

## 📚 Template Descriptions

### GitHub Templates

- **Issue Templates**: Standardized formats for bug reports and feature requests
- **PR Template**: Structure for pull request descriptions to improve review process
- **Workflows**: GitHub Actions CI/CD pipeline configurations
- **CODEOWNERS**: Define who's responsible for different parts of the codebase

### Git Configuration

- **.gitignore Templates**: Common patterns for different project types
- **Git Attributes**: Control how files are handled (line endings, diffing, etc.)
- **Global Config**: Recommended Git settings and aliases

### Git Hooks

- **Pre-commit**: Runs before commit to ensure code quality
- **Commit-msg**: Validates commit message format
- **Pre-push**: Runs tests before pushing
- **Setup Script**: Easily install hooks across team

### Documentation Templates

- **README**: Project overview and getting started guide
- **CONTRIBUTING**: Guidelines for contributing to the project
- **Workflow Guide**: Documentation of Git workflow
- **Release Process**: Steps for creating and deploying releases

## 🔍 Related Resources

- [Module 5: Pull Requests & Code Review](../05-pull-requests/README.md)
- [Module 6: GitHub Features](../06-github-features/README.md)
- [Module 7: Advanced Git Commands](../07-advanced-commands/README.md)
- [Module 11: Onboarding & Documentation](../11-onboarding/README.md)
