# Dotfiles

Collection of configurations

## Setup

Run the following commands to run the installations script

```
git clone git@github.com:danielpafonso/dotfiles.git
cd dotfiles
sh install-dotfiles.sh
```

## More info

### Adding New Configurations

1. Add your config file to the appropriate directory in `configs/`
2. Update `scripts/configs.toml` with the new configuration entry
3. Run `python3 scripts/generate_shell.py` to regenerate installation scripts
4. Test changes

### Configuration Format (scripts/configs.toml)

#### Regular Configurations

```toml
[configs.example]
install_path = "$HOME/.example"
source_config = "$PWD/configs/example/config"
menu_entry = "Example Config"
prompt_path = "example"
folder = false  # Set to true for directory installations
```

#### Notes Configurations

Notes use a special nested structure that allows multiple note files to be combined into a single output file:

```toml
[notes]
install_path = "$HOME/notes.txt"      # Where combined notes will be installed
menu_entry = "notes"                  # Menu display text
prompt_path = "notes"                 # Prompt identifier

[notes.parts]
# Each note part follows the pattern: <name>.install_path and <name>.menu_entry
example.install_path = "$PWD/configs/notes/example.txt"
example.menu_entry = "example topic"

another.install_path = "$PWD/configs/notes/another.txt"
another.menu_entry = "another topic"
```
