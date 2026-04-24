# this is inspired by the base version from rockylinux 9's /etc/skel after
# some minor syntax cleanup and the prepend_path function to ensure that
# ~/.local/bin is always first

if [[ -f /etc/bashrc ]]; then
  . /etc/bashrc
fi

function prepend_path {
  local prepend_dir=$1
  readarray -t -d: dirs < <(printf '%s' "${PATH}")
  PATH="${prepend_dir}"
  for dir in "${dirs[@]}"; do
    if [[ "${dir}" == "${prepend_dir}" ]]; then
      continue;
    fi
    PATH="${PATH}:${dir}"
  done
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

