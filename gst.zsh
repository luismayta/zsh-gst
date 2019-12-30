#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install gst for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#
gst_package_name=gst

function gst::dependences {
    message_info "Installing dependences for $gst_package_name"
    message_success "Installed dependences for $gst_package_name"
}

function gst::packages {
    message_info "Install packages for $gst_package_name"
    message_success "Installed packages for $gst_package_name"
}

function gst::install {
    gst::dependences
    message_info "Installing $gst_package_name"
    message_success "Installed $gst_package_name"
}

function gst::post_install {
    message_info "Post Install $gst_package_name"
    message_success "Success Install $gst_package_name}"
}

function gst::load {
}

gst::load

if ! type -p gst > /dev/null; then
    gst::install
    gst::post_install
fi
