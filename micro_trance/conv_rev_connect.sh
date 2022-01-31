#!/bin/bash
sleep 3

lsp-plugins-impulse-reverb-stereo -c lsp-plugins-impulse-reverb-stereo_CONF_STNICOLAS.cfg &

sleep 1
echo "lsp-plugins-impulse-reverb-stereo LOADED"

jack_disconnect ChucK:outport\ 2 system:playback_3
jack_disconnect ChucK:outport\ 3 system:playback_4

jack_connect ChucK:outport\ 2 impulse_reverb_stereo:in_l
jack_connect ChucK:outport\ 3 impulse_reverb_stereo:in_r

jack_connect impulse_reverb_stereo:out_l system:playback_1
jack_connect impulse_reverb_stereo:out_r system:playback_2

