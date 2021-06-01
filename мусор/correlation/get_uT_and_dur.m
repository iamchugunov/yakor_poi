function [uT_Post1,uT_Post2,uT_Post3,uT_Post4,dur_Post1,dur_Post2,dur_Post3,dur_Post4] = get_uT_and_dur(mod_frame_freq)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
uT_Post1 = [mod_frame_freq.Post1.uT].';
uT_Post2 = [mod_frame_freq.Post2.uT].';
uT_Post3 = [mod_frame_freq.Post3.uT].';
uT_Post4 = [mod_frame_freq.Post4.uT].';
dur_Post1 = [mod_frame_freq.Post1.dur].';
dur_Post2 = [mod_frame_freq.Post2.dur].';
dur_Post3 = [mod_frame_freq.Post3.dur].';
dur_Post4 = [mod_frame_freq.Post4.dur].';
end

