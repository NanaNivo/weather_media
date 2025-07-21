# CI/CD Setup for Weather App

This document describes the Continuous Integration and Continuous Deployment (CI/CD) setup for the Weather App.

## CI/CD Pipeline

Our CI/CD pipeline consists of the following stages:

1. **Build Stage**
   - Code checkout
   - Flutter setup
   - Dependencies installation
   - Code formatting check
   - Static analysis
   - Unit tests
   - APK build

2. **Deploy Stage**
   - Triggered only on main branch
   - Deploys to Firebase App Distribution (configured)
   - Can be extended for Play Store deployment

## Setup Instructions

### 1. GitHub Actions Setup

The workflow is already configured in `.github/workflows/ci_cd.yml`. To activate:

1. Go to your GitHub repository settings
2. Navigate to "Secrets and variables" → "Actions"
3. Add the following secrets:
   - `FIREBASE_APP_ID`: Your Firebase App ID
   - `FIREBASE_TOKEN`: Your Firebase CLI token

### 2. Version Management

A version bumping script is provided in `scripts/bump_version.sh`. To use:

```bash
# Bump patch version (0.0.1 → 0.0.2)
./scripts/bump_version.sh patch

# Bump minor version (0.1.0 → 0.2.0)
./scripts/bump_version.sh minor

# Bump major version (1.0.0 → 2.0.0)
./scripts/bump_version.sh major
```

### 3. Pre-commit Hooks

To enable pre-commit hooks:

```bash
# Make the pre-commit hook executable
chmod +x .git/hooks/pre-commit

# Create a symlink if you're using a custom hooks directory
ln -s ../../.git/hooks/pre-commit .git/hooks/pre-commit
```

## Development Workflow

1. Create a feature branch from main
2. Make your changes
3. Commit changes (pre-commit hooks will run automatically)
4. Create a Pull Request
5. CI will run automatically on PR
6. After merge to main, CD will deploy to Firebase

## Best Practices

1. **Versioning**
   - Use semantic versioning (MAJOR.MINOR.PATCH)
   - Bump version before releasing
   - Tag releases in git

2. **Commits**
   - Write clear commit messages
   - Reference issue numbers
   - Keep commits focused and atomic

3. **Pull Requests**
   - Include description of changes
   - Reference related issues
   - Wait for CI to pass before merging

4. **Testing**
   - Add tests for new features
   - Maintain test coverage
   - Run tests locally before pushing

## Troubleshooting

### Common Issues

1. **CI Build Failures**
   - Check the GitHub Actions logs
   - Ensure all tests pass locally
   - Verify Flutter version matches CI

2. **Deploy Failures**
   - Verify Firebase credentials
   - Check app signing configuration
   - Ensure version code is incremented

### Support

For CI/CD related issues:
1. Check the Actions tab in GitHub
2. Review the workflow logs
3. Verify your secrets are properly set
4. Ensure branch protections are configured correctly 