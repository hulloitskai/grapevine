# container-linux-config
*A basic Container Linux / Ignition configuration for [CoreOS](https://coreos.com/os/docs/latest/), and related distros.*

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg)](https://github.com/prettier/prettier) [![ct: v0.7.0](https://img.shields.io/badge/ct-v0.7.0-green.svg)](https://github.com/coreos/container-linux-config-transpiler/releases/tag/v0.7.0) [![ignition: v2.1.0](https://img.shields.io/badge/ignition-v2.1.0-blue.svg)](https://coreos.com/ignition/docs/latest/configuration-v2_1.html)

Check out the [latest release](https://github.com/steven-xie/grapevine-config/releases)!

### Usage
See `src/` for active configurations.
 
 To build a Container Linux config, run `yarn make`. This command reads `src/container-linux-config.yml`, parses it with `tools/ct` [*(config-transpiler)*](https://github.com/coreos/container-linux-config-transpiler), prettifies it with [prettier](https://github.com/prettier/prettier), and places it in the `out/` directory.
