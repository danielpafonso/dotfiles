"""Generate sh installation scripts"""

import tomllib

CONFIG_PATH = "scripts/configs.toml"
INSTALL_TEMPLATE = "scripts/install-dotfiles.sh.tmpl"
VARIABLE_TEMPLATE = "scripts/variables.sh.tmpl"
OUTPUT_VARIABLES = "variables.sh"
OUTPUT_INSTALL = "install-dotfiles.sh"


def extract_replace_loop(template: str, tag: str, count: int = -1) -> tuple:
    """Extract loop and replace with a tag"""
    start = template.find(tag)
    end = template.find("{{END}}", start)
    extract = template[start : end + 7]

    template_lines = template.replace(extract, tag, count).split("\n")
    for i, line in enumerate(template_lines):
        if line.endswith(tag):
            template_lines[i] = tag
            break

    return "\n".join(template_lines), "\n".join(extract.split("\n")[1:-1])

def extract_replace_inline(template: str, tag: str, count: int = -1) -> tuple:
    """Extract loop and replace with a tag"""
    start = template.find(tag)
    end = template.find("{{END}}", start)
    extract = template[start : end + 7]
    return template.replace(extract, tag, count), extract[len(tag):-7]


def generate_variables(configs: dict) -> None:
    """Generate variables sh file"""
    print("Generate variables file")
    ## read template
    with open(VARIABLE_TEMPLATE, "r", encoding="utf8") as ifp:
        template = ifp.read()

    ## extract and process CONFIG
    template, config_tmpl = extract_replace_loop(template, "{{CONFIG}}")
    output_config = []
    for key, values in configs["configs"].items():
        output_config.append(
            (
                config_tmpl.replace("{{key}}", key.upper())
                .replace("{{install_path}}", values["install_path"])
                .replace("{{source_config}}", values["source_config"])
            )
        )
    template = template.replace("{{CONFIG}}", "\n".join(output_config))

    ## extract and process NOTES_ALL
    template, notes_all = extract_replace_loop(template, "{{NOTES_ALL}}")
    template = template.replace(
        "{{NOTES_ALL}}",
        notes_all.replace("{{install_path}}", configs["notes"]["install_path"]),
    )

    ## extract and process NOTES_PARTS
    template, parts_tmpl = extract_replace_loop(template, "{{NOTES_PARTS}}")
    output_notes = []
    for key, values in configs["notes"]["parts"].items():
        output_notes.append(
            (
                parts_tmpl.replace("{{key}}", key.upper()).replace(
                    "{{install_path}}", values["install_path"]
                )
            )
        )
    template = template.replace("{{NOTES_PARTS}}", "\n".join(output_notes))

    ## Write variables script
    with open(OUTPUT_VARIABLES, "w", encoding="utf8") as ofp:
        ofp.write(template)


def generate_install(configs: dict) -> None:
    """Generate install sh script file"""
    ## read template
    print("Generate install file")
    with open(INSTALL_TEMPLATE, "r", encoding="utf8") as tfp:
        template = tfp.read()

    ## Generate Install/apply
    # dotfiles
    template, install_tmpl = extract_replace_loop(template, "{{INSTALL_DOTFILES}}")
    install_configs = []
    for key, values in configs["configs"].items():
        install_configs.append(
            install_tmpl.replace("{{key}}", key.upper()).replace(
                "{{folder}}", "folder" if values.get("folder", False) else ""
            )
        )
    template = template.replace("{{INSTALL_DOTFILES}}", "\n".join(install_configs))

    # notes
    template, install_menu_tmpl = extract_replace_loop(template, "{{INSTALL_NOTES}}")
    notes_install = []
    for key in configs["notes"]["parts"]:
        notes_install.append(install_menu_tmpl.replace("{{key}}", key.upper()))
    template = template.replace("{{INSTALL_NOTES}}", "\n".join(notes_install))

    ## Generate Menu
    # dotfiles
    template, menu_dotfiles = extract_replace_loop(template, "{{MENU_DOTFILES}}")
    menu_configs = []
    for i, (key, values) in enumerate(configs["configs"].items()):
        menu_configs.append(
            (
                menu_dotfiles.replace("{{idx}}", str(i + 1))
                .replace("{{key}}", key.upper())
                .replace("{{menu_entry}}", values["menu_entry"])
            )
        )
    template = template.replace("{{MENU_DOTFILES}}", "\n".join(menu_configs))
    # notes
    template, notes_all_tmpl = extract_replace_loop(template, "{{MENU_NOTES_ALL}}")
    template = template.replace(
        "{{MENU_NOTES_ALL}}",
        notes_all_tmpl.replace("{{idx}}", str(len(configs["configs"]) + 1)).replace(
            "{{menu_entry}}", configs["notes"]["menu_entry"]
        ),
    )
    ## Generate Choice switch case
    # dotfiles
    template, menu_notes_tmpl = extract_replace_loop(template, "{{CHOICE_DOTFILES}}")
    choice_dotfiles = []
    for i, (key, values) in enumerate(configs["configs"].items()):
        choice_dotfiles.append(
            (
                menu_notes_tmpl.replace("{{idx}}", str(i + 1))
                .replace("{{key}}", key.upper())
                .replace("{{prompt_path}}", values["prompt_path"])
            )
        )
    template = template.replace("{{CHOICE_DOTFILES}}", "\n".join(choice_dotfiles))
    # notes all
    template, notes_all_tmpl = extract_replace_loop(template, "{{CHOICE_NOTES_IDX}}")
    template = template.replace(
        "{{CHOICE_NOTES_IDX}}",
        notes_all_tmpl.replace("{{idx}}", str(len(configs["configs"]) + 1))
            .replace("{{key}}", "NOTES")
            .replace("{{prompt_path}}", configs["notes"]["prompt_path"]),
    )

    ## Generate Notes Sub Menu
    template, submenu_notes = extract_replace_loop(template, "{{SUB_MENU_NOTES}}")
    menu_configs = []
    for i, (key, values) in enumerate(configs["notes"]["parts"].items()):
        menu_configs.append(
            (
                submenu_notes.replace("{{idx}}", str(i + 2))
                .replace("{{key}}", key.upper())
                .replace("{{menu_entry}}", values["menu_entry"])
            )
        )
    template = template.replace("{{SUB_MENU_NOTES}}", "\n".join(menu_configs))

    ## Generate Notes Sub Menu Choices
    while template.find("{{CHOICE_NOTES_NEWLINE}}") != -1:
        template, submenu_choices = extract_replace_loop(template, "{{CHOICE_NOTES_NEWLINE}}", 1) 
        choices = []
        for key in configs["notes"]["parts"].keys():
            choices.append(submenu_choices.replace("{{key}}", key.upper()))
        template = template.replace("{{CHOICE_NOTES_NEWLINE}}", "\n".join(choices), 1)

    while template.find("{{CHOICE_NOTES_&&}}") != -1:
        template, submenu_choices = extract_replace_inline(template, "{{CHOICE_NOTES_&&}}", 1) 
        choices = []
        for key in configs["notes"]["parts"].keys():
            choices.append(submenu_choices.replace("{{key}}", key.upper()))
        template = template.replace("{{CHOICE_NOTES_&&}}", " && ".join(choices), 1)

    template, submenu_notes = extract_replace_loop(template, "{{CHOICE_SUB_MENU_NOTES}}")
    menu_configs = []
    for i, (key, values) in enumerate(configs["notes"]["parts"].items()):
        menu_configs.append(
            (
                submenu_notes.replace("{{idx}}", str(i + 2))
                .replace("{{key}}", key.upper())
            )
        )
    template = template.replace("{{CHOICE_SUB_MENU_NOTES}}", "\n".join(menu_configs))

    # write template
    with open(OUTPUT_INSTALL, "w", encoding="utf8") as ofp:
        # remove trailing whitespaces
        for line in template.splitlines():
            ofp.write(f"{line.rstrip()}\n")

    return
    menu = []
    num = 1
    # Generate menu
    for key, values in configs["configs"].items():
        up_key = key.upper()
        menu.append(
            (
                f'printf " {num}) [%s] {values["menu_entry"]}\\n    path: %s\\n" '
                f'"${up_key}_INSTALL" "${up_key}_PATH"'
            )
        )
        num += 1

    menu.append(
        (
            f'printf " {num}) [%s] {configs["notes"]["menu_entry"]}\\n    path: %s\\n" '
            '"$NOTES_ALL_INSTALL" "$NOTES_PATH"'
        )
    )
    letters = "abcdefghijkmlnopqrstuvwxyz"
    i = 0
    line = []
    args = []
    for key, values in configs["notes"]["parts"].items():
        line.append(f'{letters[i]}) [%s] {values["menu_entry"]}')
        args.append(f'"$NOTES_{key.upper()}"')
        if len(line) == 4:
            menu.append(f'printf "  {" ".join(line)}\\n" {" ".join(args)}')
            line = []
            args = []
        i += 1
    # append remaining
    if line:
        menu.append(f'printf "  {" ".join(line)}\\n" {" ".join(args)}')
    template = template.replace("{{MENU}}", "\n\t".join(menu))

    # generate choice
    choice = []
    num = 1
    for key, values in configs["configs"].items():
        up_key = key.upper()
        choice.append(
            f'{num}) {up_key}_INSTALL=$([ "${up_key}_INSTALL" = "*" ] && echo " " || echo "*")'
        )
        choice.append("\t;;")
        choice.append(f'"path {num}")')
        choice.append(f'\tprintf "\\n {values["prompt_path"]} path> "')
        choice.append(f"\tread {up_key}_PATH")
        choice.append("\t;;")
        num += 1

    notes_choice = ["NOTES_ALL_INSTALL"] + [
        f"NOTES_{key.upper()}" for key in configs["notes"]["parts"].keys()
    ]
    notes_choice = [f"NOTES_{key.upper()}" for key in configs["notes"]["parts"].keys()]

    choice.append(f'{num}) if [ "$NOTES_ALL_INSTALL" = " " ]; then')
    choice.append('\t\tNOTES_ALL_INSTALL="*"')
    for notes in notes_choice:
        choice.append(f'\t\t{notes}="*"')
    choice.append("\telse")
    choice.append('\t\tNOTES_ALL_INSTALL=" "')
    for notes in notes_choice:
        choice.append(f'\t\t{notes}=" "')
    choice.append("\tfi")
    choice.append("\t;;")
    choice.append(f'"path {num}")')
    choice.append(f"\tprintf \"\\n {configs['notes']['prompt_path']} path> \"")
    choice.append("\tread NOTES_PATH")
    choice.append("\t;;")

    ## notes path
    unselected = " && ".join([f'[ "${x.upper()}" = " " ]' for x in notes_choice])
    selected = " && ".join([f'[ "${x.upper()}" = "*" ]' for x in notes_choice])
    toogle = f"""\tif {selected}; then
\t\t\t\tNOTES_ALL_INSTALL="*"
\t\t\telif {unselected}; then
\t\t\t\tNOTES_ALL_INSTALL=" "
\t\t\telse
\t\t\t\tNOTES_ALL_INSTALL="-"
\t\t\tfi
\t\t\t;;"""

    i = 0
    for key, values in configs["notes"]["parts"].items():
        choice.append(
            (
                f'"{num}{letters[i]}") NOTES_{key.upper()}=$([ "$NOTES_{key.upper()}" = "*" ] &&'
                'echo " " || echo "*")'
            )
        )
        choice.append(toogle)
        i += 1

    template = template.replace("{{CHOICE}}", "\n\t\t".join(choice))


if __name__ == "__main__":
    with open(CONFIG_PATH, "rb") as cfp:
        toml_configs = tomllib.load(cfp)

    generate_variables(toml_configs)
    generate_install(toml_configs)
