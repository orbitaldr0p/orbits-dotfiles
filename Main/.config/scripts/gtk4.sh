#!/bin/bash
home_dir=$HOME
config_dir="/.config"
themes_dir="/.themes"

if [[ "$1" == "--reset" ]]; then
    echo -e "\n***\nResetting theme to default!\n***\n"
    rm "${home_dir}${config_dir}/gtk-4.0/gtk.css"
    rm "${home_dir}${config_dir}/gtk-4.0/gtk-dark.css"
    rm "${home_dir}${config_dir}/gtk-4.0/assets"
    rm "${home_dir}${config_dir}/assets"
else
    all_themes=($(ls "${home_dir}${themes_dir}/"))
    
    echo "Select theme: "
    for ((i=0; i<${#all_themes[@]}; i++)); do
        echo "$((i+1)). ${all_themes[i]}"
    done
    
    echo -e "e. Exit"
    read -p "Your choice: " chk

    case $chk in
        "e")
            echo "Bye bye!"
            ;;
        *)
            chk_value=$((chk-1))
            chk_theme=${all_themes[chk_value]}
            echo -e "\n***\nChoosed ${chk_theme}\n***\n"
            
            echo "Removing previous theme..."
            rm "${home_dir}${config_dir}/gtk-4.0/gtk.css"
            rm "${home_dir}${config_dir}/gtk-4.0/gtk-dark.css"
            rm "${home_dir}${config_dir}/gtk-4.0/assets"
            rm "${home_dir}${config_dir}/assets"
            
            echo "Installing new theme..."
            ln -s "${home_dir}${themes_dir}/${chk_theme}/gtk-4.0/gtk.css" "${home_dir}${config_dir}/gtk-4.0/gtk.css"
            ln -s "${home_dir}${themes_dir}/${chk_theme}/gtk-4.0/gtk-dark.css" "${home_dir}${config_dir}/gtk-4.0/gtk-dark.css"
            ln -s "${home_dir}${themes_dir}/${chk_theme}/gtk-4.0/assets" "${home_dir}${config_dir}/gtk-4.0/assets"
            ln -s "${home_dir}${themes_dir}/${chk_theme}/assets" "${home_dir}${config_dir}/assets"
            
            echo "Done."
            ;;
    esac
fi
