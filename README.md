# Environment

> `$HOME` sweet `$HOME`.

![Tank](https://user-images.githubusercontent.com/6618434/65382519-eb433480-dccc-11e9-9f15-827945187805.jpg)

My configuration files and initialization scripts for Windows/macOS/Linux.

## Features

- 🧛‍♂️ Consistent colors with [Dracula](https://draculatheme.com/).
- 📝 Fully-equipped text editing with [VS Code](https://code.visualstudio.com/).
- 🍺 Cross-platform packages with [Homebrew](https://brew.sh/).
- 🛠 Version-controlled development tools with [`asdf`](https://asdf-vm.com/).
- 🐠 Friendly shell experience with [`fish`](https://fishshell.com/).
- 🖥 Modern terminal experience with
  [`kitty`](https://sw.kovidgoyal.net/kitty/)/[Windows
  Terminal](https://github.com/microsoft/terminal).
- ⌨️ Synchronized keyboard setup between Windows/macOS.

## Initial Setup

Run the `init.sh` script:

  ```shell
  ./init.sh
  ```

## Updating Programs

Programs (installed with `apt`, `brew`, `asdf`, and `fisher`) can be updated
with the `update.sh` script:

```shell
./update.sh
```

## Configuration Files

Configuration files are located in the `config` folder. They're split up into
folders for each program they're related to.

### Substitution

When copying configuration files to their destinations, any section that looks
like `{{this}}` will be substituted with the output of the shell command between
the braces.

### Setup Scripts

For each configuration file, you can have a "setup" script. For example, if you
have a configuration file called `settings.json`, you can optionally have a file
called `settings.json.setup.sh` in the same folder. This file will be executed
immediately before reading the configuration file and can be used to set
variables or functions that can then be used within substitutions in the
configuration file.

### Available Functions

Within substitutions and setup scripts, you can use the following functions:

- `os_status` allows you to query properties about the current operating system.
  This can be used to implement conditional configuration per-OS.
- `secret` allows you to retrieve the value of a named "secret" (a value that is
  needed in a configuration file but should not be stored within this repository
  for security or privacy reasons). When calling `secret` for a value that has
  not yet been stored, you will be prompted to enter a value.

## Syncing Configuration

Configuration syncing is specified by the `config/sync.sh` script. Within it,
you can use the bi-directional functions `copy` and `run`:

- `copy` allows you to specify a config folder and a destination folder. On
  `push`, files will be copied from the config folder to the destination folder.
  On `pull`, files will be copied from the destination folder to the config
  folder.
- `run` allows you to specify a script to run on `push` and a script to run on
  `pull`. The scripts will be run from their containing folder.

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
`config/sync.sh`. If a file with substitutions is changed, the substituted
values will be pulled in, so make sure to ignore those changes.
