#!/usr/bin/env zsh

DEPENDENCES_ZSH+=( zpm-zsh/helpers zpm-zsh/colors )

RUST_PREFIX=${RUST_PREFIX:-" "}
RUST_SUFIX=${RUST_SUFIX:-""}

if command -v zpm >/dev/null; then
  zpm zpm-zsh/helpers zpm-zsh/colors
fi

pr_rust=""

_pr_rust() {
  
  if (( $+commands[rustc] )); then
    if is-recursive-exist Cargo.toml ; then
      pr_rust="$RUST_PREFIX"
      
      rust_version=$(rustc --version | cut -d' ' -f2)
      if [[ $CLICOLOR = 1 ]]; then
        pr_rust+="%{$c[red]${c_bold}%}𝗥%{$c_reset%} %{$c[blue]$c_bold%}$rust_version%{$c_reset%}"
      else
        pr_rust+="𝗥 $rust_version"
      fi
      
      pr_rust+="$RUST_SUFIX"
      return 0
    fi
  fi
  
  pr_rust=""
  
}

_pr_rust
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _pr_rust
