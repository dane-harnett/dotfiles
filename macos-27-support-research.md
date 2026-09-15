# macOS 27 compatibility check

## External sources

Checked on 15 September 2026. These findings concern project support. Local versions and runtime checks must be assessed separately.

Apple lists macOS 27 Golden Gate as available from 14 September. [Apple](https://www.apple.com/os/macos/)

| Component | Support evidence | Limits and reported faults |
| --- | --- | --- |
| Homebrew | The installation guide supports macOS 15 through 27 on Apple Silicon. | Current Xcode Command Line Tools are required for a supported installation. Homebrew puts Nix-managed installations in Tier 3. This is a support policy, not proof of a failure. Individual casks and formulae can have separate faults. [Installation](https://docs.brew.sh/Installation), [Support tiers](https://docs.brew.sh/Support-Tiers) |
| Karabiner-Elements | The project lists version 16.3.0 for macOS 27. | This support statement does not prove support for an older installed version. No current macOS 27 fault was confirmed in this check. [Project](https://karabiner-elements.pqrs.org/) |
| Docker Desktop | Docker supports the current and two previous major macOS releases. Since Apple now lists macOS 27 as released, the policy includes macOS 27. | This is an inference from the stated policy. It does not prove that an older installed version works. The release page lists 4.90.0, dated 7 September 2026. No macOS 27 fault was confirmed in the reviewed Docker sources. [System requirements](https://docs.docker.com/desktop/setup/install/mac-install/), [Release notes](https://docs.docker.com/desktop/release-notes/) |
| Ghostty | The current download is 1.3.1 and requires macOS 13 or later. Official macOS binaries are signed and notarized. | The reviewed pages do not state explicit macOS 27 validation. A project discussion reports local-network SSH failures on macOS 27 betas. Several users report a fix in beta 5. Later reports describe a remaining fault after closing Ghostty and resuming a running tmux session. The discussion has a needs-confirmation label. This is reported beta evidence, not a confirmed final-release fault. [Download](https://ghostty.org/download), [Binary installation](https://ghostty.org/docs/install/binary), [Discussion 13438](https://github.com/ghostty-org/ghostty/discussions/13438) |
| AeroSpace | The project supports macOS installation and remains in beta. | No explicit macOS 27 support statement was found in the reviewed project guide or releases. Search results for its bug discussions list a macOS 27 beta window flicker report, but the current discussion index did not expose that report. It is not treated as a confirmed fault. [Project](https://github.com/nikitabobko/AeroSpace), [Guide](https://nikitabobko.github.io/AeroSpace/guide), [Releases](https://github.com/nikitabobko/AeroSpace/releases), [Bug discussions](https://github.com/nikitabobko/AeroSpace/discussions/categories/potential-bugs) |
| Nix and nix-darwin | Nix documents macOS installation. nix-darwin supports Nix and Lix. | Neither reviewed page gives an explicit macOS 27 support statement. General macOS support does not prove that the selected revisions work on macOS 27. No failure of Nix or nix-darwin itself on the final release was confirmed. [Nix](https://nixos.org/download/), [nix-darwin](https://github.com/nix-darwin/nix-darwin) |

An open nix-homebrew report from 12 June states that a Nix-managed Homebrew installation rejects macOS 27 with `unknown or unsupported macOS version: :dunno`. The report does not give the selected Homebrew revision or a confirmed fix. This can affect old pinned inputs. It does not contradict current Homebrew support. [Issue 152](https://github.com/zhaofengli/nix-homebrew/issues/152)

An open Nixpkgs report states that OpenCode 1.18.11 has an invalid executable signature on macOS 27 beta 4. The report uses unstable Nixpkgs and Lix. This is package-specific beta evidence. It does not establish a general Nix failure. [Issue 550300](https://github.com/NixOS/nixpkgs/issues/550300)

No final-release incompatibility was confirmed by the reviewed external sources. An absent support statement is an evidence gap, not evidence of incompatibility.

## Current repository checks

Checked commit `18c44c9`. The computer still runs macOS 26.6.2, build 25G83. No runtime tests on macOS 27 were performed.

- AeroSpace has no remaining Borders calls. The Nix keyboard mapping block is removed. The two earlier configuration concerns are resolved.
- Nixpkgs is now locked to `c7def046b9a883d46974757852106483d741586f`. Evaluation still selects `karabiner-elements-15.7.0`. The input update did not update this package to 16.3.0. Support for 15.7.0 on macOS 27 remains unconfirmed.
- `nix flake check --no-build --no-update-lock-file --offline` passed. All declared checks evaluated. The system was not built or activated, and the formatting and lint derivations were not executed.
- Parsing passed for all eight tracked JSON, JSONC, and TOML files. Shell syntax checks passed for the Zsh configuration, Nix utility scripts, browser script, and full-screen script. The diff whitespace check passed.
- Disabled Borders files and a Home Manager link remain. AeroSpace does not use them, so they do not create an active Borders dependency.
- OpenCode is installed through Homebrew, not the Nixpkgs package in the reported beta fault. That report does not establish a fault in this configuration.
- The Homebrew source input has been updated, but its exact revision was not validated on macOS 27. A recent source date alone does not prove compatibility.

The remaining package concern is Karabiner-Elements 15.7.0. Select a release with stated macOS 27 support before the OS upgrade. Nix activation, Touch ID for sudo, AeroSpace window management, Karabiner input, GUI applications, and Neovim plugins need runtime checks after the upgrade. The repository has no confirmed macOS 27 failure from this check, but full compatibility is not established.

No configuration or lock file was changed during this check. This report is the only added file.
