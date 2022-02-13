#!/bin/bash
killall lsp-plugins-para-equalizer-x16-stereo
lsp-plugins-para-equalizer-x16-stereo -c para_eq_base_conf.cfg &

sleep 1

jack_disconnect ChucK:outport\ 0 system:playback_1
jack_disconnect ChucK:outport\ 1 system:playback_2

jack_connect ChucK:outport\ 0 para_equalizer_x16_stereo:in_l
jack_connect ChucK:outport\ 1 para_equalizer_x16_stereo:in_r

jack_connect para_equalizer_x16_stereo:out_l system:playback_1
jack_connect para_equalizer_x16_stereo:out_r system:playback_2
