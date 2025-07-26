# Contributing to Hyprland-Dots

Thank you for your interest in contributing to Hyprland-Dots! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Prerequisites

- Arch Linux or compatible distribution
- Hyprland compositor installed
- Basic knowledge of Wayland compositors
- Familiarity with dotfiles configuration

### Getting Started

1. **Fork the repository**

   ```bash
   git clone https://github.com/your-username/Hyprland-Dots.git
   cd Hyprland-Dots
   ```

2. **Create a new branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Test your changes**
   - Backup your existing configurations
   - Test the installation script in a safe environment
   - Verify all configurations work correctly

## 📋 Contribution Guidelines

### Code Style

- Use consistent indentation (4 spaces for shell scripts)
- Add comments for complex configurations
- Follow existing naming conventions
- Keep configurations modular and well-organized

### Configuration Standards

- **Hyprland configs**: Place in `hypr/` directory with appropriate subdirectories
- **Waybar configs**: Use the existing `waybar/configs` and `waybar/style` structure
- **Scripts**: Place executable scripts in `hypr/scripts/` with `.sh` extension
- **Themes**: Add theme files to appropriate subdirectories

### Commit Message Format

```
type(scope): description

[optional body]

[optional footer]
```

Types:

- `feat`: New feature or configuration
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

Examples:

```
feat(waybar): add new minimalist theme configuration
fix(hypr): resolve keybinding conflict in workspace switching
docs(readme): update installation instructions for NixOS
```

## 🔧 Types of Contributions

### Configuration Enhancements

- New Waybar themes and layouts
- Hyprland window rules and animations
- Rofi themes and configurations
- Kitty terminal themes

### Scripts and Automation

- System utility scripts
- Configuration management tools
- Installation and setup scripts
- Status monitoring scripts

### Documentation

- Setup guides for different distributions
- Configuration explanations
- Troubleshooting guides
- Feature documentation

### Bug Fixes

- Configuration errors
- Script compatibility issues
- Installation problems
- Performance optimizations

## 🧪 Testing

### Before Submitting

1. **Backup Testing**: Ensure the backup functionality works correctly
2. **Clean Installation**: Test on a fresh Hyprland installation
3. **Multi-Monitor**: Test with different monitor configurations
4. **Performance**: Check for performance regressions

### Test Checklist

- [ ] Installation script runs without errors
- [ ] All keybindings work as expected
- [ ] Waybar displays correctly
- [ ] No configuration conflicts
- [ ] Scripts execute properly
- [ ] Themes apply correctly

## 📝 Pull Request Process

1. **Update Documentation**: Update README.md if you add new features
2. **Add Examples**: Include screenshots or examples for visual changes
3. **Test Thoroughly**: Ensure your changes don't break existing functionality
4. **Describe Changes**: Provide a clear description of what your PR does

### PR Template

```markdown
## Description

Brief description of changes

## Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement

## Testing

- [ ] Tested on clean Hyprland installation
- [ ] Verified backward compatibility
- [ ] No regression in existing features

## Screenshots (if applicable)

Add screenshots to help explain your changes
```

## 🐛 Bug Reports

When reporting bugs, please include:

- OS and distribution version
- Hyprland version
- Error messages or logs
- Steps to reproduce
- Expected vs actual behavior

## 💡 Feature Requests

For new features:

- Explain the use case
- Describe the proposed solution
- Consider implementation complexity
- Check if similar features exist

## 📞 Getting Help

- **Issues**: Use GitHub issues for bugs and feature requests
- **Discussions**: Use GitHub discussions for questions and ideas
- **Community**: Join the Hyprland community discord

## 🏆 Recognition

Contributors will be recognized in:

- README.md contributors section
- Release notes for significant contributions
- Special thanks for major improvements

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project.

---

**Happy Contributing!** 🚀
