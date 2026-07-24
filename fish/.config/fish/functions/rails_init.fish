
function rails_init --description "Initialise un projet Rails"
    # Adapte selon ton rails_init.zsh
    # Exemple générique :
    if not test -f Gemfile
        echo " ❌ Pas dans un projet Rails"
        return 1
    end

    echo "🚀 Initialisation Rails..."
    bundle install
    rails db:prepare
    echo "✅ Projet prêt !"
end
