# Environment

> `$HOME` sweet `$HOME`.

![Tank](https://user-images.githubusercontent.com/6618434/65382519-eb433480-dccc-11e9-9f15-827945187805.jpg)

My configuration files and initialization scripts for macOS/Linux.

## Initial Setup

- Install Homebrew:

  - [macOS](https://docs.brew.sh/Installation)
  - [Linux](https://docs.brew.sh/Homebrew-on-Linux)

- Install dependencies for `asdf` programs that will be compiled from source:

  - [Erlang](https://github.com/asdf-vm/asdf-erlang#before-asdf-install)
  - [Postgres](https://github.com/smashedtoatoms/asdf-postgres#dependencies)

- Run the `init` script:

  ```shell
  ./init.sh
  ```

## Syncing Configuration

Configuration syncing is specified by the `config/sync.sh` script. Within it,
you can use the the bi-directional operations `copy` and `run`:

- `copy` allows you to specify a config folder and a destination folder. On
  `push`, files will be copied from the config folder to the destination folder.
  On `pull`, files will be copied from the destination folder to the config
  folder.
- `run` allows you to specify a script to run on `push` and a script to run on
  `pull`. The scripts will be run from their containing directory.

If configuration is changed inside the repository, run the `push.sh` script:

```shell
./push.sh
```

This will copy files from `config` into the system and run scripts according to
`config/sync.sh`. When copying files, any section that looks like `{{this}}`
will be substituted with the output of the shell command between the braces.

If configuration is changed outside the repository, run the `pull.sh` script:

```shell
./pull.sh
```

This will copy files into `config` from the system and run scripts according to
`config/sync.sh`. If a file with substitutions is changed, its substituted
values will be pulled in, so make sure to ignore those changes.

## Updating Programs

Programs (installed with `brew`, `asdf`, and `fisher`) can be updated with the
`update.sh` script:

```shell
./update.sh
```
