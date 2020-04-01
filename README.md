# Environment

> `$HOME` sweet `$HOME`.

![Tank](https://user-images.githubusercontent.com/6618434/65382519-eb433480-dccc-11e9-9f15-827945187805.jpg)

My configuration files and initialization scripts for macOS/Linux.

## Initial Setup

- Install Homebrew:

  - [macOS](https://docs.brew.sh/Installation)
  - [Linux](https://docs.brew.sh/Homebrew-on-Linux)

- Install dependencies for programs that will be compiled from source:

  - [Erlang](https://github.com/asdf-vm/asdf-erlang#before-asdf-install)
  - [Postgres](https://github.com/smashedtoatoms/asdf-postgres#dependencies)

- Run the `init` script:

  ```shell
  ./init.sh
  ```

## Changing Configuration

If configuration files are changed inside the repository, run the `push` script:

```shell
./push.sh
```

This will copy files from the `config` directory into the `$HOME` directory. Any
section that looks like `{{this}}` will be substituted with the output of the
shell command between the braces.

If configuration files are changed outside the repository, run the `pull`
script:

```shell
./pull.sh
```

This will pull configuration files into the `config` directory. If a file with
substitutions is changed, its substituted values will be pulled in, so make sure
to ignore those changes.
