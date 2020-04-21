#!/usr/bin/env zsh

: ${RUST_PREFIX:=' '}
: ${RUST_SUFIX:=''}

typeset -g pr_rust=''

if (( $+commands[rustc] )); then
  function _pr_rust() {
    if is-recursive-exist Cargo.toml; then
      rust_version=$(rustc --version | cut -d' ' -f2)

      pr_rust="${RUST_PREFIX}%{${c[red]}${c[bold]}%}RUST:%{${c[reset]}%}%{${c[blue]}${c[bold]}%}${rust_version}%{${c[reset]}%}${RUST_SUFIX}"

      return 0
    fi

    pr_rust=""
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_rust
  _pr_rust
fi
