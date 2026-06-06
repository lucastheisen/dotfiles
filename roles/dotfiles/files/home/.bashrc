# this is inspired by the base version from rockylinux 9's /etc/skel after
# some minor syntax cleanup and the prepend_path function to ensure that
# ~/.local/bin is always first

if [[ -f /etc/bashrc ]]; then
  . /etc/bashrc
fi

function prepend_path {
  local dirs=("$@")

  local current_dirs
  IFS=: read -ra current_dirs <<<"${PATH}"
  for current_dir in "${current_dirs[@]}"; do
    for dir in "${dirs[@]}"; do
      if [[ "${dir}" == "${current_dir}" ]]; then
        continue 2
      fi
    done
    dirs+=("${current_dir}")
  done

  IFS=: PATH="${dirs[*]}"
}

if [[ -d ~/.bashrc.d ]]; then
  prepend_path "${HOME}/.local/bin"
  for rc in ~/.bashrc.d/*; do
    if [[ -f "${rc}" ]]; then
      . "${rc}"
      prepend_path "${HOME}/.local/bin"
    fi
  done
fi

unset rc
unset prepend_path

