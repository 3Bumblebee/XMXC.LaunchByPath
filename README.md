## XMXC Launch By Path
#### (Xenia Manager Xenia Canary Launch By Path)

### Overview

The **XMXC Launch By Path** is a PowerShell tool designed to enhance compatibility and usability for [Xenia Manager](https://github.com/xenia-manager/xenia-manager), an awesome frontend for [Xenia Canary](https://github.com/xenia-canary/xenia-canary). This tool solves ~~two~~ one key challenge (for me):

1. Launching games by their file path instead of their title, making it compatible with third-party frontends like [LaunchBox](https://www.launchbox-app.com/).
2. ~~Eliminating the User Account Control (UAC) prompt that appears when launching a game.~~ No need for this since version 2.3.0

> **Note:** This tool is not affiliated with the development of Xenia Manager or Xenia Canary. Full credit goes to their respective creators for their remarkable work.

---

### Features

- Launch games using file paths rather than titles.
- Simplifies the use of Xenia Manager with third-party frontends like LaunchBox.
- ~~Avoids UAC prompts during game launches.~~
- Includes helper scripts for:
  - A **CMD-based method** (`XMXC.cmd`) to bypass PowerShell execution policy restrictions.
  - A **standalone executable** (`XMXC.ToExe.ps1`) for easy deployment.

---

### How It Works

This tool cross-references the specified game path against Xenia Manager's `Config\games.json` file. If a matching `game_location` is found, it retrieves the associated `config_location` for the same game. Using these values, it composes a command to launch Xenia Canary with the proper configuration.

---

### Included Files

1. **XMXC.LaunchByPath.ps1**: The main PowerShell script for launching games by path.
2. **XMXC.cmd**: A helper CMD script for third-party frontends, avoiding execution policy restrictions.
3. **XMXC.ToExe.ps1**: A script for converting the tool into a standalone executable.

---

### How to Use

#### **CMD Version**
1. Place **XMXC.LaunchByPath.ps1** and **XMXC.cmd** in the root directory of your Xenia Manager installation.
2. Configure your frontend (e.g., LaunchBox) to use **XMXC.cmd** to launch games by their file paths.

#### **EXE Version**
1. Place **XMXC.ToExe.ps1** and **XMXC.LaunchByPath.ps1** in the root directory of your Xenia Manager installation.
2. Run **XMXC.ToExe.ps1** to convert **XMXC.LaunchByPath.ps1** into **XMXC.exe**.
3. Configure your frontend (e.g., LaunchBox) to use **XMXC.exe** to launch games by their file paths.

---

### Acknowledgments

This tool relies on the excellent work of the following projects:

- **[Xenia Manager](https://github.com/xenia-manager/xenia-manager):** A tool designed to simplify the use of the Xenia mulator.
- **[Xenia Canary](https://github.com/xenia-canary/xenia-canary):** A experimental fork of the Xenia emulator.

---

### Disclaimer

This is an independent project and is not officially endorsed by the creators of Xenia Manager or Xenia Canary.
