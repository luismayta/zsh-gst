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
GST_DOWNLOAD_URL="https://github.com/uetchy/gst/releases/download"

GST_VERSION="v5.0.3"
GST_OSX="gst_darwin_amd64"
GST_LINUX="gst_darwin_amd64"
GST_PATH_BIN="${HOME}/bin"
GST_BIN="${GST_PATH_BIN}/${gst_package_name}"

function gst::install::osx {
    curl -L "${GST_DOWNLOAD_URL}/${GST_VERSION}/${GST_OSX}" > "${GST_BIN}"
    chmod +x "${GST_BIN}"
}

function gst::install::linux {
    curl -L "${GST_DOWNLOAD_URL}/${GST_VERSION}/${GST_LINUX}" > "${GST_BIN}"
    chmod +x "${GST_BIN}"
}

function gst::dependences::install {
    message_info "Installing Dependences for ${gst_package_name}"
    message_success "${gst_package_name} Dependences Installed"
}

function gst::dependences::checked {
    if ! type -p curl > /dev/null; then
        message_error "Please install curl for  ${gst_package_name}"
        return
    fi
}

function gst::install {
    gst::dependences::checked
    message_info "Installing ${gst_package_name}"
    case "${OSTYPE}" in
    darwin*)
        gst::install::osx
        ;;
    linux*)
        gst::install::linux
    ;;
    esac
    message_success "${gst_package_name} Installed"
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
    [ -e "${GST_PATH_BIN}" ] && export PATH="${PATH}:${GST_PATH_BIN}"
}

gst::load

if ! type -p gst > /dev/null; then
    gst::install
    gst::post_install
fi
