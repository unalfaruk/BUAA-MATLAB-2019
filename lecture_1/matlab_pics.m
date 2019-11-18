function matlab_pics
clc
clear all
close all

%% The Story Behind the MATLAB Default Image
% Image display was added in version 4 of MATLAB, sometime around 1990.  
% Many observant users noticed that the low-level image display object had
% default pixel values.  In other words, if you called |image| with no
% input arguments, it would display a small image.  If you were a MATLAB 4
% user, you might have seen something like this:
%
% <<http://blogs.mathworks.com/images/steve/87/dp.png>>

%%
% When MATLAB 5 was released, some users noticed that the default image had
% changed.

figure(1),subplot(1,3,1)
% image
imagesc(get(0,'DefaultImageCData'))
colormap(gray(32))
axis image
% axis equal
title('The default image');
%%
% A few users also noticed that the
% pixel values in the new default image were not integers.

h = findobj(gcf,'type','image');
cdata = get(h,'CData');
cdata(1:3,1:3)

figure(1),subplot(1,3,2)
imagesc(floor(cdata))
colormap(gray(32))
axis image
% axis equal
title('The integer part');

%%
% Is there something interesting about the fractional part?

figure(1),subplot(1,3,3)
imagesc(cdata - floor(cdata))
colormap(gray(32))
axis image
% axis equal
title('The fractional part');

%%
% Apparently so.
%
% I now confess - you can blame me for all of this.  I told this story in
% public for the first time last week at the IEEE International Conference
% on Image Processing in Atlanta, GA.  Now, dear blog readers, you get to
% hear it, too.
%
% I joined The MathWorks toward the end of 1993.  Sometime in 1994, the
% company held its first employee charity auction.  One of the "items"
% put up for bid was the right to choose the default image for MATLAB 5,
% which was then under development.  As the new "image processing guy" in
% development, I felt some responsibility to bid.  (At least, that's the
% way I tried to explain it later to my wife.)  As it turned out, another
% MathWorks developer really wanted to win this item, so to win it I ended
% up paying big bucks.  (It's all for charity, I kept reminding myself.)
%
% Once I won the auction, I had to decide what image to pick.  During this
% time, I frequently heard complaints from users that MATLAB could only
% handle double-precision values.  (That lasted until 1997.)  Because I 
% heard so much about this issue, I decided that I would use all of the
% mantissa bits for the new default image.  I solicited ideas from my
% fellow developers for what to include.
%
% Here are the various images "hidden" in different bit slices of the
% default image pixel values.  (To run the code yourself, download this
% little utility function, <http://blogs.mathworks.com/images/steve/87/bitslice.m 
% bitslice>.)

%%
% The image stored in the 5 most-significant bits is the one you usually
% see.  This is my oldest son.

defimage = pow2(get(0,'DefaultImageCData'),47);
mag = 200;
figure(2),subplot(3,5,1)
imshow(bitslice(defimage,47,51), 'initialmag', mag);
title('the oldest son');

%%
% The next 5 bits show a dog that belonged to a MathWorks developer.
figure(2),subplot(3,5,2)
imshow(bitslice(defimage,42,46), 'initialmag', mag);
title('the dog of one developer');
%%
%
% Here's another MathWorks pet.
figure(2),subplot(3,5,3)
imshow(bitslice(defimage,37,41), 'initialmag', mag);
title('another pet of one developer');

%%
% This famous matrix is the inverse of the 3-by-3 Hilbert matrix.
figure(2),subplot(3,5,4)
imshow(bitslice(defimage,36,36), 'initialmag', mag);
title('3-by-3 Hilbert matrix');

%%
% This is a low-resolution version of the company's original logo.
figure(2),subplot(3,5,5)
imshow(bitslice(defimage,35,35), 'initialmag', mag);
title('company''s original logo');

%%
% Loren's favorite number.
figure(2),subplot(3,5,6)
imshow(bitslice(defimage,34,34), 'initialmag', mag);
title('Loren''s favorite number');

%%
% 3-by-3 magic square.
figure(2),subplot(3,5,7)
imshow(bitslice(defimage,33,33), 'initialmag', mag);
title('3-by-3 magic square');

%%
% My youngest son.
figure(2),subplot(3,5,8)
imshow(bitslice(defimage,28,32), 'initialmag', mag);
title('the youngest son');

%%
% A famous magic square hidden in Albrecht Durer's Melancolia.
figure(2),subplot(3,5,9)
imshow(bitslice(defimage,23,27), 'initialmag', mag);
title('magic square hidden in Melancolia');

%%
% I couldn't resist a kind of visual pun.  This is the original MATLAB 
% "eight-bit image."  (That'll tell you something about my sense of humor.)
figure(2),subplot(3,5,10)
imshow(bitslice(defimage,18,22), 'initialmag', mag);
title('company''s original logo');

%%
% Loren at age 4.
figure(2),subplot(3,5,11)
imshow(bitslice(defimage,13,16), 'initialmag', mag);
title('Loren at age 4');

%%
% Wilkinson, Givens, and Forsythe, from the 1964 Gatlinburg Conference on 
% Numerical Algebra.
figure(2),subplot(3,5,12)
imshow(bitslice(defimage,9,12), 'initialmag', mag);
title('Wilkinson, Givens, and Forsythe');

%%
% Me.
figure(2),subplot(3,5,13)
imshow(bitslice(defimage,5,8), 'initialmag', mag);
title('the author');

%%
% The original default image from MATLAB 4 is still in there.
figure(2),subplot(3,5,14)
imshow(bitslice(defimage,1,4), 'initialmag', mag);
title('original default image');

%%
% Finally, a certain combination of three bit slices makes a yellow pig
% with the number 17 superimposed on it.  I've been told this is some sort 
% of secret joke within a certain mathematical community. 
r = bitslice(defimage,0,0);
g = bitslice(defimage,17,17);
b = bitslice(defimage,34,34);
figure(2),subplot(3,5,15)
imshow(cat(3,r,g,b), 'initialmag', mag);
title('a yellow pig');

%%
% There you have it - the complete story of the MATLAB default image.


%%
% _Steve Eddins_
% _Copyright 2006 The MathWorks, Inc._


function out = bitslice(in,a,b)
[m,n]=size(in);
out = in;
for i=1:m
    for j=1:n
        bits = bitget(in(i,j),[a:b]+1);
        out(i,j) = sum(bits.*2.^(0:(length(bits)-1)));
    end
end

out = out./max(out(:))*255;
out = uint8(out);