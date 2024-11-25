# Environment

> `$HOME` sweet `$HOME`.

![Tank](https://user-images.githubusercontent.com/6618434/65382519-eb433480-dccc-11e9-9f15-827945187805.jpg)

My configuration files and initialization scripts for Windows/macOS/Linux.

## Features

- 🧛‍♂️ Consistent colors with [Dracula](https://draculatheme.com/).
- 📝 Fully-equipped text editing with [VS Code](https://code.visualstudio.com/).
- 🍺 Cross-platform packages with [Homebrew](https://brew.sh/).
- 🛠 Version-controlled development tools with [`asdf`](https://asdf-vm.com/).
- 🐠 Friendly shell with [`fish`](https://fishshell.com/).
- 🖥 Modern terminal with [WezTerm](https://wezfurlong.org/wezterm/).
- ⌨️ Uniform keyboard setup between Windows/macOS.

## Initial Setup

If running on Windows, set `WSLENV` to [share environment variables between
Windows and
WSL](https://docs.microsoft.com/en-us/windows/wsl/filesystems#share-environment-variables-between-windows-and-wsl-with-wslenv):

```
WSLENV=USERPROFILE/up:APPDATA/up:ProgramFiles/up
```

Run the `init.sh` script:

```shell
./init.sh
```

## Updating Programs

Programs (`apt`/`brew` packages, `asdf` tools, and `fisher` plugins) can be
updated with the `update.sh` script:

```shell
./update.sh
```

## Configuration Files

Configuration files are located in the `config` folder. They're split up into
folders for each program they're related to.

### Substitution

When copying configuration files to their destinations, any section that looks
like `{{command}}` will be substituted with the output of executing `command`.

### Available Functions

Within substitutions and scripts, you can use the following functions:

- `os_status` queries properties about the current operating system. This can be
  used to implement conditional configuration per-OS.

- `read_config` prints the content of a config file with substitutions
  evaluated.

- `merge_config` merges the content of a config file with a destination file.

- `read_local` prints the content of a config file under the `local` folder.
  This can be used to extend files with local configuration. When calling
  `read_local` for a file that doesn't exist, an empty file will be created.

- `secret` retrieves the value of a named "secret" (a value that is needed in a
  configuration file but should not be stored within this repository for
  security or privacy reasons). When calling `secret` for a value that has not
  yet been stored, you will be prompted to enter a value.

- `command_key` prints the OS-appropriate command key. The uniform keyboard
  setup is meant to act like macOS, so command key behavior is emulated in other
  environments.

- `windows_run` runs a command directly in Windows.

## Syncing Configuration

Configuration synchronization is specified by the `config/sync.sh` script.
Within it, you can use the bi-directional `copy` function along with the
`on_push` and `on_pull` functions:

- `copy` requires you to specify a config folder and a destination folder. On
  `push`, files will be copied from the config folder to the destination folder.
  On `pull`, files will be copied from the destination folder to the config
  folder.

- `on_push` requires you to specify a script to run on `push`.

- `on_pull` requires you to specify a script to run on `pull`.

The scripts for `on_push` and `on_pull` will be run from their containing
folder.

If configuration is changed inside the repository, run the `push.sh` script:

```shell
./push.sh
```

This will copy files from `config` into the system and run scripts according to
`config/sync.sh`.

If configuration is changed outside the repository, run the `pull.sh` script:

```shell
./pull.sh
```

This will copy files into `config` from the system and run scripts according to
`config/sync.sh`. If lines near a substitution are changed, running `pull.sh`
could result in conflicts. Make sure to resolve these before committing.
