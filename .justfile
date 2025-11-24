#!/usr/bin/env -S just --justfile

set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

[doc('Bootstrap Recipes')]
mod bootstrap '.just/bootstrap.just'

[private]
default:
    just --list

[positional-arguments, private]
log lvl msg *args:
    gum log -t rfc3339 -s -l "{{lvl}}" "{{msg}}" {{args}}
