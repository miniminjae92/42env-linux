# 🚀 42 Cluster Environment Setup

My personal configuration files for the 42 cluster environment. This repository helps you quickly set up a productive and beautiful terminal environment.

## ✨ Features

* **Shell:** Zsh with Oh My Zsh
* **Prompt:** Powerlevel10k for a fast and informative prompt.
* **Terminal Multiplexer:** Tmux with custom keybindings and a stylish theme.
* **Fuzzy Finder:** fzf for blazing-fast file and history search.
* **AI Integration:** Easy setup for the Gemini CLI for AI assistance directly from the terminal.
* **Neovim for 42:** Custom keybindings for 42-specific tasks, including automatic header creation and Norminette formatting.

---

## 💻 Environment

Based on the information provided, this configuration is optimized for:

* **Operating System:** Ubuntu 22.04 LTS
* **Architecture:** x86_64
* **Shell:** Zsh

---

## 🔧 Dependencies

This setup relies on specific versions of the following tools. To ensure compatibility and avoid potential issues, it's recommended to use the same versions.

* **Neovim:** v0.11.0
* **tmux:** 3.2a
* **fzf:** 0.65.1

---

## ⚙️ Installation

**Warning:** The installation script will back up your existing configuration files (like `.zshrc`, `.tmux.conf`, etc.) to a `~/.dotfiles_backup_...` directory before creating new ones.

1.  **Clone the repository into the `goinfre` folder:**
    ```bash
    cd ~/goinfre && \
    git clone git@github.com:miniminjae92/42env-linux.git
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

## 🤖 Using the Gemini CLI

To use the Gemini CLI with this environment, follow these steps:

1.  Create a file named `.gemini.env` in your **home directory (`~`)**.
2.  Add your API key to this file like so:
    ```
    export GOOGLE_API_KEY="your-api-key"
    export GEMINI_API_KEY="$GOOGLE_API_KEY"
    ```
3.  The `~/.zshrc` configuration will automatically load this key and set it as an environment variable for you. If you prefer to store this file in a different location, you can modify the `if [ -f "$HOME/.gemini.env" ]` line in your `.zshrc` to match the new path. If your `node` binary path is different, please update the `export PATH` line in `~/.zshrc` to match your path.

---

## ⌨️ Neovim Features for 42

This setup includes special keybindings to simplify 42 project workflows:

* Press **F1** to automatically insert the 42 header at the top of your file.
* Press **Space + f** to format your code to comply with Norminette standards.

---

## 🔧 Customization

All configuration files are located in the `configs/` directory. You can modify them directly to suit your needs. After making changes, you don't need to run the installer again as they are symbolically linked.

## 🤝 Contributing

Contributions are welcome! If you have an improvement or a bug fix, please follow these steps:

1.  **Fork** this repository.
2.  Create a new branch (`git checkout -b feature/your-awesome-feature`).
3.  Make your changes and **commit** them (`git commit -m 'Add some feature'`).
4.  **Push** to the branch (`git push origin feature/your-awesome-feature`).
5.  Open a **Pull Request**.

I will review the changes and merge them if they align with the project's goals.
