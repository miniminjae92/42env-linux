# 🚀 42 Cluster Environment Setup

My personal configuration files for the 42 cluster environment. This repository helps you quickly set up a productive and beautiful terminal environment.

## ✨ Features

- **Shell:** Zsh with Oh My Zsh
- **Prompt:** Powerlevel10k for a fast and informative prompt.
- **Terminal Multiplexer:** Tmux with custom keybindings and a stylish theme.
- **Fuzzy Finder:** fzf for blazing-fast file and history search.
- *(Add more features as you add more configs)*

---

## ⚙️ Installation

**Warning:** The installation script will back up your existing configuration files (like `.zshrc`, `.tmux.conf`, etc.) to a `~/.dotfiles_backup_...` directory before creating new ones.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/miniminjae92/42env-linux
    ```

2.  **Run the installation script:**
    The script will automatically create symbolic links for the configuration files.
    ```bash
    cd 42env-linux/gs42/scripts && \
    chmod +x setup.sh && \
    ./setup.sh
    ```

3.  **Restart your shell:**
---

## 🔧 Customization

All configuration files are located in the `configs/` directory. You can modify them directly to suit your needs. After making changes, you don't need to run the installer again as they are symbolically linked.

---

## 🤝 Contributing

Contributions are welcome! If you have an improvement or a bug fix, please follow these steps:

1.  **Fork** this repository.
2.  Create a new branch (`git checkout -b feature/your-awesome-feature`).
3.  Make your changes and **commit** them (`git commit -m 'Add some feature'`).
4.  **Push** to the branch (`git push origin feature/your-awesome-feature`).
5.  Open a **Pull Request**.

I will review the changes and merge them if they align with the project's goals.
