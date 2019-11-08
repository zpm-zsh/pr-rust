#!/usr/bin/env zsh

DEPENDENCES_ZSH+=( zpm-zsh/helpers zpm-zsh/colors )

RUST_PREFIX=${RUST_PREFIX:-" "}
RUST_SUFIX=${RUST_SUFIX:-""}

if (( $+functions[zpm] )); then
  zpm zpm-zsh/helpers,inline zpm-zsh/colors,inline
fi

pr_rust=""

_pr_rust() {
  if (( $+commands[rustc] )); then
    if is-recursive-exist Cargo.toml >/dev/null ; then
      pr_rust="$RUST_PREFIX"
      
      rust_version=$(rustc --version | cut -d' ' -f2)
      pr_rust+="%{$c[red]${c_bold}%}𝗥%{$c_reset%} %{$c[blue]$c_bold%}$rust_version%{$c_reset%}"
      pr_rust+="$RUST_SUFIX"

      return 0
    fi
  fi
  
  pr_rust=""
}

_pr_rust
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _pr_rust
