function latest_installed_packages
cat /var/log/pacman.log | grep -w installed | cut -c45- | sed -e "s/[(][^)]*[)]/()/g" | tr -d '()' | tr -d ' '
end
