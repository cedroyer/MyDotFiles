if [[ -r "$HOME/.profile" ]]
then
    source "$HOME/.profile"
fi
if [[ -r "$HOME/.profile_local" ]]
then
    source "$HOME/.profile_local"
fi
