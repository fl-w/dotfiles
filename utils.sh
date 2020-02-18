#!/bin/bash

function print_info() {
  printf '\n\033[36m%s\033[0m\n' "$1"
}

function print_warning() {
  print '\n\033[33mWARN:\033[0m %s\n' "$1"
}

function print_success() {
  print '\n\033[32mSUCCESS:\033[0m %s\n' "$1"
}

function print_err() {
  print '\n\033[31mERROR:\033[0m %s\n' "$1"
}

function _update() {

}
