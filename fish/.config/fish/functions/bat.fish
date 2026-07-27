function bat --description 'wrapper bat/batcat selon la distro linux'
    if command -v batcat >/dev/null 2>&1
        command batcat $argv
    else if command -v bat >/dev/null 2>&1
        command bat $argv
    else
        echo "bat/batcat n'est pas installé"
        return 1
    end
end
