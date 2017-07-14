# Source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Use .bashrc unless items needed specifically for interactive logins
# And probably even then, after the test

# Source host specific bash_profile if it exists
if [ -f "${HOME}/.bash_profile_env" ] ; then
  source "${HOME}/.bash_profile_env"
fi


