# Contributing to docker-on-tre

Thank you for your interest in contributing to this repository.

This project is primarily intended as **teaching material** for the CHME0039
course and as a **reference implementation** for running Docker-based workflows
inside Trusted Research Environments (TREs).

Contributions that improve clarity, robustness, or reproducibility are welcome.

---

## What Contributions Are Welcome

Examples include:

- Documentation improvements (README clarity, troubleshooting, diagrams)
- Bug fixes in Docker or Compose configuration
- Improvements to example scripts
- Small quality-of-life improvements for teaching or workshops

Large feature additions should be discussed first.

---

## How to Contribute

1. Fork the repository
2. Create a feature branch from `main`
   ```bash
   git checkout -b feature/your-change
   ```
3. Make your changes
4. Commit with a clear message
   ```bash
   git commit -m "Improve TRE setup documentation"
   ```
5. Push your branch and open a Pull Request

---

## Development Guidelines

- Keep changes **simple and instructional**
- Avoid introducing unnecessary dependencies
- Assume **air-gapped execution** as a core constraint
- Prefer explicit steps over automation when teaching concepts

---

## Code Style

- Follow standard Python formatting conventions
- Keep shell commands POSIX-compatible where possible
- Comment non-obvious Docker decisions

---

## Licensing

By contributing, you agree that your contributions will be licensed under the
MIT License.

---

Thank you for helping improve this teaching resource.
