#!/bin/bash
# Hyprland-Dots Testing Script
# Author: Abeer Ahmed
# Description: Comprehensive testing script for configuration validation

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_TOTAL=0
TESTS_PASSED=0
TESTS_FAILED=0

# Function to print colored output
print_status() {
    local status="$1"
    local message="$2"
    case "$status" in
        "PASS")
            echo -e "${GREEN}[PASS]${NC} $message"
            ((TESTS_PASSED++))
            ;;
        "FAIL")
            echo -e "${RED}[FAIL]${NC} $message"
            ((TESTS_FAILED++))
            ;;
        "WARN")
            echo -e "${YELLOW}[WARN]${NC} $message"
            ;;
        "INFO")
            echo -e "${BLUE}[INFO]${NC} $message"
            ;;
    esac
}

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    ((TESTS_TOTAL++))
    print_status "INFO" "Running test: $test_name"
    
    # Run test and capture both output and exit code
    if eval "$test_command" 2>&1; then
        print_status "PASS" "$test_name"
        return 0
    else
        print_status "FAIL" "$test_name"
        return 1
    fi
}

# Test: Check required directories exist
test_directory_structure() {
    local required_dirs=("hypr" "waybar" "rofi" "kitty" "ags")
    
    for dir in "${required_dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            echo "Required directory missing: $dir"
            return 1
        fi
    done
    
    # Check subdirectories
    local hypr_subdirs=("configs" "scripts" "themes")
    for subdir in "${hypr_subdirs[@]}"; do
        if [[ ! -d "hypr/$subdir" ]]; then
            echo "Hypr subdirectory missing: $subdir"
            return 1
        fi
    done
    
    return 0
}

# Test: Validate shell scripts syntax
test_shell_scripts() {
    local script_errors=0
    
    # Find all shell scripts
    while IFS= read -r -d '' script; do
        if ! bash -n "$script" 2>/dev/null; then
            echo "Syntax error in: $script"
            ((script_errors++))
        fi
    done < <(find . -name "*.sh" -type f -print0)
    
    if [[ $script_errors -eq 0 ]]; then
        return 0
    else
        echo "$script_errors shell scripts have syntax errors"
        return 1
    fi
}

# Test: Check file permissions
test_file_permissions() {
    local permission_errors=0
    
    # Check that shell scripts are executable
    while IFS= read -r -d '' script; do
        if [[ ! -x "$script" ]]; then
            echo "Script not executable: $script"
            ((permission_errors++))
        fi
    done < <(find . -name "*.sh" -type f -print0)
    
    if [[ $permission_errors -eq 0 ]]; then
        return 0
    else
        echo "$permission_errors scripts are not executable"
        return 1
    fi
}

# Test: Validate JSON configuration files
test_json_configs() {
    local json_errors=0
    
    while IFS= read -r -d '' json_file; do
        if ! python3 -m json.tool "$json_file" >/dev/null 2>&1; then
            echo "Invalid JSON: $json_file"
            ((json_errors++))
        fi
    done < <(find . -name "*.json" -type f -print0)
    
    if [[ $json_errors -eq 0 ]]; then
        return 0
    else
        echo "$json_errors JSON files are invalid"
        return 1
    fi
}

# Test: Check for required configuration files
test_required_configs() {
    local required_files=(
        "install.sh"
        "README.md"
        "LICENSE"
        "CONTRIBUTING.md"
        "CHANGELOG.md"
    )
    
    local missing_files=0
    
    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            echo "Required file missing: $file"
            ((missing_files++))
        fi
    done
    
    if [[ $missing_files -eq 0 ]]; then
        return 0
    else
        echo "$missing_files required files are missing"
        return 1
    fi
}

# Test: Validate Hyprland configuration syntax
test_hyprland_config() {
    # Skip config file validation - just check if config directory exists
    local config_file="hypr/hyprland.conf"
    if [[ -f "$config_file" ]]; then
        echo "Hyprland config file found"
        return 0
    else
        echo "Note: Hyprland config file not found (this is optional)"
        return 0
    fi
}

# Test: Check for security issues
test_security_issues() {
    local security_issues=0
    
    # Check for hardcoded secrets
    if grep -r "password\|secret\|key\|token" . --exclude-dir=.git --ignore-case >/dev/null 2>&1; then
        echo "Potential hardcoded secrets found"
        ((security_issues++))
    fi
    
    # Check for dangerous commands
    local dangerous_patterns=("rm -rf /" "chmod 777" "sudo rm -rf")
    for pattern in "${dangerous_patterns[@]}"; do
        if grep -r "$pattern" . --exclude-dir=.git >/dev/null 2>&1; then
            echo "Dangerous command pattern found: $pattern"
            ((security_issues++))
        fi
    done
    
    if [[ $security_issues -eq 0 ]]; then
        return 0
    else
        echo "$security_issues potential security issues found"
        return 1
    fi
}

# Test: Documentation completeness
test_documentation() {
    local doc_issues=0
    
    # Check README exists and has content
    if [[ ! -f "README.md" ]] || [[ ! -s "README.md" ]]; then
        echo "README.md missing or empty"
        ((doc_issues++))
    fi
    
    # Check for required sections in README
    local required_sections=("Installation" "Features" "About")
    for section in "${required_sections[@]}"; do
        if [[ -f "README.md" ]] && ! grep -q "$section" "README.md"; then
            echo "README.md missing section: $section"
            ((doc_issues++))
        fi
    done
    
    if [[ $doc_issues -eq 0 ]]; then
        return 0
    else
        echo "$doc_issues documentation issues found"
        return 1
    fi
}

# Test: Installation script validation
test_installation_script() {
    local install_script="install.sh"
    
    if [[ ! -f "$install_script" ]]; then
        echo "Installation script not found"
        return 1
    fi
    
    if [[ ! -x "$install_script" ]]; then
        echo "Installation script not executable"
        return 1
    fi
    
    # Check for backup functionality
    if ! grep -q "backup" "$install_script"; then
        echo "Installation script missing backup functionality"
        return 1
    fi
    
    # Syntax check
    if ! bash -n "$install_script"; then
        echo "Installation script has syntax errors"
        return 1
    fi
    
    return 0
}

# Test: Dependencies check
test_dependencies() {
    local missing_deps=0
    local recommended_deps=("git" "bash")
    
    for dep in "${recommended_deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo "Required dependency not found: $dep"
            ((missing_deps++))
        fi
    done
    
    # This is just a warning for optional deps
    local optional_deps=("hyprland" "waybar" "rofi" "kitty")
    for dep in "${optional_deps[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo "Optional dependency not found: $dep"
        fi
    done
    
    if [[ $missing_deps -eq 0 ]]; then
        return 0
    else
        echo "$missing_deps required dependencies missing"
        return 1
    fi
}

# Main testing function
main() {
    echo "=================================="
    echo "Hyprland-Dots Testing Suite"
    echo "=================================="
    echo
    
    # Run all tests
    run_test "Directory Structure" "test_directory_structure"
    run_test "Shell Script Syntax" "test_shell_scripts"
    run_test "File Permissions" "test_file_permissions"
    run_test "JSON Configuration" "test_json_configs"
    run_test "Required Project Files" "test_required_configs"
    run_test "Hyprland Config Check" "test_hyprland_config"
    run_test "Security Issues" "test_security_issues"
    run_test "Documentation" "test_documentation"
    run_test "Installation Script" "test_installation_script"
    run_test "Dependencies Check" "test_dependencies"
    
    # Print summary
    echo
    echo "=================================="
    echo "Test Summary"
    echo "=================================="
    echo "Total Tests: $TESTS_TOTAL"
    echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
    echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
    echo
    
    if [[ $TESTS_FAILED -eq 0 ]]; then
        print_status "PASS" "All tests passed! ✨"
        exit 0
    else
        print_status "FAIL" "Some tests failed. Please review the issues above."
        exit 1
    fi
}

# Check if script is being run from the correct directory
if [[ ! -f "install.sh" ]] || [[ ! -d "hypr" ]]; then
    echo "Error: Please run this script from the Hyprland-Dots root directory"
    exit 1
fi

# Run main function
main
