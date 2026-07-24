
function stop_rails --description "Stoppe le serveur Rails en cours"
    # Vérification projet Rails
    if not test -f Gemfile; or not grep -q 'rails' Gemfile
        echo " ❌ Vous n'êtes pas dans un projet Rails"
        return 1
    end

    set pid_file "tmp/pids/server.pid"

    if not test -f $pid_file
        echo " ❌ Aucun fichier PID trouvé ($pid_file)"
        return 1
    end

    set pid (cat $pid_file)

    if test -z "$pid"
        echo " ❌ Le fichier PID est vide"
        return 1
    end

    if kill -9 $pid 2>/dev/null
        echo "✅ Serveur Rails (PID: $pid) stoppé avec succès"
        rm -f $pid_file
    else
        echo "⚠️  Impossible de killer le processus (PID: $pid) - peut-être déjà arrêté ?"
        rm -f $pid_file
        return 1
    end
end
