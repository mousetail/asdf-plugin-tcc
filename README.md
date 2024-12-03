<div align="center">

# asdf-plugin-tcc [![Build](https://github.com/mousetail/asdf-plugin-tcc/actions/workflows/build.yml/badge.svg)](https://github.com/mousetail/asdf-plugin-tcc/actions/workflows/build.yml) [![Lint](https://github.com/mousetail/asdf-plugin-tcc/actions/workflows/lint.yml/badge.svg)](https://github.com/mousetail/asdf-plugin-tcc/actions/workflows/lint.yml)

[plugin-tcc](https://github.com/mousetial/asdf-plugin-tcc) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add plugin-tcc
# or
asdf plugin add plugin-tcc https://github.com/mousetail/asdf-plugin-tcc.git
```

plugin-tcc:

```shell
# Show all installable versions
asdf list-all plugin-tcc

# Install specific version
asdf install plugin-tcc latest

# Set a version globally (on your ~/.tool-versions file)
asdf global plugin-tcc latest

# Now plugin-tcc commands are available
tcc --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/mousetail/asdf-plugin-tcc/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Maurits "Mousetail" van Riezen](https://github.com/mousetail/)
