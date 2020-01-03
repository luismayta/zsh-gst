#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install gst for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#
# Links:
#
# gst: https://github.com/uetchy/gst
#
#
#

gst_package_name=gst
GST_PATH_BIN=/usr/local/bin
GST_BIN="${GST_PATH_BIN}/${gst_package_name}"

function gst::install::osx {
    curl -L https://github.com/uetchy/gst/releases/download/v5.0.1/gst_darwin_amd64 > "${GST_BIN}"
    chmod +x "${GST_BIN}"
}

function gst::install::linux {
    curl -L https://github.com/uetchy/gst/releases/download/v5.0.1/gst_linux_amd64 > "${GST_BIN}"
    chmod +x "${GST_BIN}"
}

function gst::dependences::install {
    messages_info "Installing Dependences for ${gst_package_name}"
    messages_success "${gst_package_name} Dependences Installed"
}

function gst::dependences::checked {
    if ! type -p curl > /dev/null; then
        messages_error "Please install curl for  ${gst_package_name}"
    fi
}

function gst::install {
    gst::dependences::checked
    messages_info "Installing ${gst_package_name}"
    case "${OSTYPE}" in
    darwin*)
        gst::install::osx
        ;;
    linux*)
        gst::install::linux
    ;;
    esac
    messages_success "${gst_package_name} Installed"
}

function gst::post_install {
    message_info "Post Install $gst_package_name"
    message_success "Success Install $gst_package_name"
}

# Wrapper for gst new
function gst::new {
    gst new "${1}"
    if type -p ghq > /dev/null; then
        ghq::cache::clear > /dev/null
    fi
}

# load dependences
function gst::load {
    path_append "${GST_PATH_BIN}"
}

gst::load

if ! type -p gst > /dev/null; then
    gst::install
    gst::post_install
fi
