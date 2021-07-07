function [uT_Post,dur_Post] = get_uT_and_dur(Post)
%return the time of arrival and duration of the impulse
%from Post in nanoseconds
uT_Post = [Post.uT].'/1;
dur_Post = [Post.dur].'.*10;
end

