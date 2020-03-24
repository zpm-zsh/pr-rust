#!/usr/bin/env zsh

: ${RUST_PREFIX:=" "}
: ${RUST_SUFIX:=""}

typeset -g pr_rust=""

if (( $+commands[rustc] )); then
  function _pr_rust() {
    if is-recursive-exist Cargo.toml; then
      rust_version=$(rustc --version | cut -d' ' -f2)

      pr_rust="${RUST_PREFIX}%{$c[red]${c_bold}%}𝗥%{$c_reset%} %{$c[blue]$c_bold%}${rust_version}%{$c_reset%}${RUST_SUFIX}"

      return 0
    fi

    pr_rust=""
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _pr_rust
  _pr_rust
fi
