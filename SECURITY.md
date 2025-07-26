# Security Policy

## Supported Versions

We actively support and provide security updates for the following versions:

| Version | Supported              |
| ------- | ---------------------- |
| 2.1.x   | ✅ Yes                 |
| 2.0.x   | ✅ Yes                 |
| 1.x     | ❌ No longer supported |

## Reporting a Vulnerability

### 🔒 Security Issues

If you discover a security vulnerability in this project, please report it responsibly:

#### 📧 Private Reporting

1. **Email**: Send details to the maintainer via GitHub private message
2. **GitHub Security**: Use GitHub's private vulnerability reporting feature
3. **Include**: Detailed description, steps to reproduce, and potential impact

#### ⏱️ Response Timeline

- **Initial Response**: Within 48 hours
- **Assessment**: Within 7 days
- **Resolution**: Varies by severity (1-30 days)
- **Public Disclosure**: After fix is released

### 🚨 Security Scope

#### What to Report

- **Configuration Vulnerabilities**: Unsafe default settings
- **Script Vulnerabilities**: Dangerous commands or permissions
- **Installation Security**: Unsafe installation procedures
- **Dependency Issues**: Known vulnerabilities in dependencies

#### Out of Scope

- **Hyprland Core Issues**: Report to upstream Hyprland project
- **System Configuration**: General Linux security configurations
- **Third-party Packages**: Issues with Waybar, Rofi, etc.

### 🛡️ Security Best Practices

#### For Users

1. **Review Scripts**: Always review installation scripts before execution
2. **Backup First**: Create backups before installation
3. **Limited Permissions**: Don't run with unnecessary privileges
4. **Keep Updated**: Use latest supported versions

#### For Contributors

1. **Code Review**: All changes undergo security review
2. **Input Validation**: Validate all user inputs in scripts
3. **Least Privilege**: Scripts use minimal required permissions
4. **Safe Defaults**: Configure secure defaults

### 🔍 Known Security Considerations

#### Current Mitigations

- **Script Validation**: Installation scripts are validated for dangerous commands
- **Backup System**: Automatic backup creation before modifications
- **Permission Checks**: Proper file permission validation
- **Input Sanitization**: User input is sanitized in scripts

#### Recommendations

- **Sandboxing**: Consider running installation in controlled environment
- **Review Changes**: Always review configuration changes
- **Monitor System**: Watch for unexpected system behavior

### 📋 Security Checklist

Before using this configuration:

- [ ] Review all scripts for potentially dangerous commands
- [ ] Backup existing configurations
- [ ] Understand what changes will be made to your system
- [ ] Run installation with appropriate user permissions
- [ ] Verify system behavior after installation

### 🏆 Security Acknowledgments

We appreciate responsible disclosure and will acknowledge security researchers who help improve the project's security.

#### Recognition

- Security contributors will be mentioned in release notes
- Serious vulnerabilities may warrant special acknowledgment
- Option for anonymous reporting if preferred

### 📞 Contact

For security-related questions or concerns:

- Use GitHub's private reporting feature
- Contact maintainers through official channels
- Join community discussions for general security topics

---

_This security policy is regularly updated to reflect current best practices and project evolution._
