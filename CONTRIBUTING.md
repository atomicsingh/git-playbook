# Contributing to Git Playbook

Thank you for your interest in contributing to the Git Playbook! This document provides guidelines for contributing to this educational resource.

## 🎯 Project Goals

The Git Playbook aims to:
- Provide comprehensive Git education for teams
- Offer practical, real-world examples
- Support different skill levels (beginner to advanced)
- Maintain up-to-date best practices
- Foster collaborative development workflows

## 🤝 How to Contribute

### Types of Contributions

We welcome several types of contributions:

1. **Content Improvements**
   - Fix typos and grammatical errors
   - Clarify confusing explanations
   - Add missing information
   - Update outdated content

2. **New Examples**
   - Real-world scenarios
   - Code samples
   - Troubleshooting cases
   - Best practice demonstrations

3. **Additional Modules**
   - Advanced topics
   - Specialized workflows
   - Tool integrations
   - Platform-specific guidance

4. **Templates and Tools**
   - Git hooks
   - Workflow templates
   - Automation scripts
   - Configuration examples

5. **Translations**
   - Module translations
   - Localized examples
   - Cultural adaptations

### Getting Started

1. **Fork the Repository**
   ```bash
   # Click "Fork" on GitHub, then clone your fork
   git clone git@github.com:yourusername/git-playbook.git
   cd git-playbook
   ```

2. **Set Up Development Environment**
   ```bash
   # Add upstream remote
   git remote add upstream git@github.com:atomic-loops/git-playbook.git
   
   # Create feature branch
   git checkout -b feature/your-contribution
   ```

3. **Make Your Changes**
   - Follow existing structure and style
   - Test examples and commands
   - Update relevant documentation

4. **Submit Your Contribution**
   ```bash
   # Commit your changes
   git add .
   git commit -m "docs: add explanation for advanced rebasing"
   
   # Push to your fork
   git push origin feature/your-contribution
   
   # Create pull request on GitHub
   ```

## 📝 Content Guidelines

### Writing Style

- **Clear and Concise**: Use simple, direct language
- **Practical Focus**: Include working examples and real scenarios
- **Progressive Complexity**: Start simple, build to advanced concepts
- **Inclusive Language**: Use welcoming, accessible terminology
- **Active Voice**: Prefer active over passive voice

### Structure

- **Consistent Headers**: Use emoji + descriptive titles
- **Code Blocks**: Always specify language for syntax highlighting
- **Examples**: Include both correct and incorrect approaches
- **Exercises**: Provide hands-on practice opportunities
- **Cross-References**: Link to related modules and concepts

### Technical Requirements

- **Accuracy**: All commands and examples must work as written
- **Current Best Practices**: Follow modern Git conventions
- **Platform Neutral**: Consider Windows, macOS, and Linux users
- **Tool Agnostic**: Focus on Git itself, mention tools as alternatives

### Formatting Standards

#### Code Examples
```bash
# ✅ Good: Clear, commented examples
git checkout -b feature/user-auth  # Create new feature branch
git add src/auth.js               # Stage authentication file
git commit -m "feat(auth): add OAuth2 integration"  # Commit with conventional message

# ❌ Avoid: Uncommented, unclear examples
git checkout -b branch
git add file
git commit -m "changes"
```

#### Explanatory Text
- Use **bold** for important concepts
- Use `code formatting` for commands, file names, and technical terms
- Use > blockquotes for important notes
- Use bullet points for lists and steps

## 🔍 Review Process

### Pull Request Guidelines

1. **Title**: Use conventional commit format
   - `docs: add section on interactive rebasing`
   - `fix: correct command syntax in Module 3`
   - `feat: add troubleshooting guide`

2. **Description**: Include:
   - What you changed and why
   - How to test the changes
   - Any breaking changes
   - Related issues or discussions

3. **Size**: Keep PRs focused and reviewable
   - Single module updates preferred
   - Large changes should be broken into smaller PRs
   - Discuss major changes in issues first

### Review Criteria

Reviewers will check:

- **Accuracy**: Do all commands work as written?
- **Clarity**: Is the content easy to understand?
- **Completeness**: Are examples complete and realistic?
- **Consistency**: Does it match existing style and structure?
- **Value**: Does it add meaningful content?

### Testing Your Changes

Before submitting:

```bash
# Test all code examples
# Verify links work
# Check spelling and grammar
# Ensure formatting is correct
# Test on different platforms if possible
```

## 🏷️ Issue Guidelines

### Reporting Issues

When reporting issues, include:

- **Clear description** of the problem
- **Steps to reproduce** if applicable
- **Expected vs actual behavior**
- **Environment details** (OS, Git version, etc.)
- **Screenshots** if helpful

### Suggesting Features

For feature suggestions:

- **Use case**: Explain why this would be valuable
- **Audience**: Who would benefit from this?
- **Scope**: How extensive would this addition be?
- **Alternatives**: Have you considered other approaches?

### Types of Issues

- 🐛 **Bug**: Something isn't working correctly
- 📝 **Documentation**: Improvements to content
- 💡 **Enhancement**: New features or improvements
- ❓ **Question**: Clarification or help needed
- 🔧 **Maintenance**: Updates, cleanup, dependencies

## 📋 Content Checklist

Before submitting content changes:

### Technical Accuracy
- [ ] All commands tested and working
- [ ] Examples use realistic scenarios
- [ ] Cross-platform compatibility considered
- [ ] Current Git best practices followed

### Content Quality
- [ ] Clear, concise writing
- [ ] Proper grammar and spelling
- [ ] Consistent with existing style
- [ ] Appropriate difficulty level
- [ ] Includes practical exercises

### Structure and Format
- [ ] Proper markdown formatting
- [ ] Consistent heading structure
- [ ] Code blocks properly formatted
- [ ] Links work correctly
- [ ] Images have alt text

### Educational Value
- [ ] Builds on previous concepts
- [ ] Explains the "why" not just "how"
- [ ] Includes common pitfalls
- [ ] Provides troubleshooting guidance
- [ ] Suitable for target audience

## 🌍 Internationalization

### Translation Guidelines

If contributing translations:

- **Maintain structure**: Keep same headings and organization
- **Adapt examples**: Use culturally appropriate examples
- **Technical terms**: Keep Git commands in English, translate explanations
- **File naming**: Use language codes (e.g., `README.es.md`)

### Cultural Considerations

- **Examples**: Use diverse, inclusive examples
- **Assumptions**: Don't assume specific cultural contexts
- **Tools**: Consider region-specific tool preferences
- **Languages**: Be mindful of right-to-left languages

## 🙏 Recognition

Contributors are recognized through:

- **Git history**: Your commits preserve your contribution
- **Contributors file**: Major contributors listed
- **Release notes**: Significant contributions highlighted
- **Community**: Recognition in discussions and social media

## 📞 Getting Help

If you need help contributing:

- **Open an issue**: For questions or clarification
- **Discussion forums**: For broader community input
- **Direct contact**: Reach out to maintainers for guidance

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project (MIT License).

---

Thank you for helping make Git more accessible to teams around the world! 🎉
