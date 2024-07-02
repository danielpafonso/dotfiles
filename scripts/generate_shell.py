"""Generate sh installation scripts"""

import tomllib


CONFIG_PATH = "scripts/configs.toml"
INSTALL_TEMPLATE = "scripts/install-dotfiles.sh.tmpl"
OUTPUT_VARIABLES = "variables.sh"
OUTPUT_INSTALL = "install-dotfiles.sh"


def generate_variables(configs: dict) -> None:
    """Generate variables sh file"""
    output_data = []
    ## Generate config
    print("Generate variables file")
    for key, values in configs["configs"].items():
        up_key = key.upper()
        output_data.append(f'{up_key}_INSTALL=" "')
        output_data.append(f'{up_key}_PATH="{values["install_path"]}"')
        output_data.append(f'{up_key}_CONFIG="{values["source_config"]}"')
        output_data.append("")

    ## generate notes
    output_data.append("")
    output_data.append('NOTES_ALL_INSTALL=" "')
    output_data.append(f'NOTES_PATH="{configs["notes"]["install_path"]}"')
    for key, value in configs["notes"]["parts"].items():
        output_data.append(f'NOTES_{key.upper()}=" "')
        output_data.append(f'NOTES_{key.upper()}_CONFIG="{value["install_path"]}"')

    output_data.append("")

    ## write output
    with open(OUTPUT_VARIABLES, "w", encoding="utf8") as ofp:
        ofp.write("\n".join(output_data))


def generate_install(configs: dict) -> None:
    """Generate install sh script file"""
    ## read template
    print("Generate install file")
    with open(INSTALL_TEMPLATE, "r", encoding="utf8") as tfp:
        template = tfp.read()

    menu = []
    num = 1
    # Generate menu
    for key, values in configs["configs"].items():
        up_key = key.upper()
        menu.append(
            (
                f'printf " {num}) [%s] {values["menu_entry"]}\\n    path: %s\\n" '
                '"${up_key}_INSTALL" "${up_key}_PATH"'
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
    template = template.replace("{{$MENU}}", "\n\t".join(menu))

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

    template = template.replace("{{$CHOICE}}", "\n\t\t".join(choice))

    # Generate Install/apply dotfiles
    apply_template = """if [ "${0}_INSTALL" != " " ]; then
\t\tapply_dotfile "${0}_CONFIG" "${0}_PATH"{1}
\tfi"""
    apply = []
    for key, values in configs["configs"].items():
        up_key = key.upper()
        apply.append(
            apply_template.format(up_key, " folder" if "folder" in values else "")
        )

    apply.append('files=""')
    apply_template = """if [ "$NOTES_{0}" != " " ]; then
\t\tfiles="${{files}} $NOTES_{0}_CONFIG"
\tfi"""
    for key in configs["notes"]["parts"].keys():
        apply.append(apply_template.format(key.upper()))

    template = template.replace("{{$INSTALL}}", "\n\t".join(apply))

    # write template
    with open(OUTPUT_INSTALL, "w", encoding="utf8") as ofp:
        ofp.write(template)


if __name__ == "__main__":
    with open(CONFIG_PATH, "rb") as cfp:
        toml_configs = tomllib.load(cfp)

    generate_variables(toml_configs)
    generate_install(toml_configs)
