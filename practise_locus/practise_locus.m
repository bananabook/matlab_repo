% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%- This is a trainer to train the root locus analysis It creates a random
% transferfunction and asks to create the root locus. It then creates the root
% locus to compare to.
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
clear
close all
clc

%- Parameters configure the trainer to your liking with these four settings

% How many roots should the transfer function have at most
max_many_roots = 2;
% What is the largest value for a coefficient in the numerator
max_numerator_coeff = 10;
% How many poles should the transfer function have at most
max_many_poles = 2;
% What is the largest value for a coefficient in the denominator
max_denom_coeff = 10;

%- Begin of function how many coefficients are we gonna have in the numerator
% and the denominator?
many_poles=randi([0,max_many_poles]); many_roots=min(randi([0,max_many_roots]), many_poles);

% fill a (the coefficients for the numerator) and b (the coefficients for the
% denominator)
a=[];
s=tf('s');
for it=1:many_roots
	a=[a,randi([-max_numerator_coeff,max_numerator_coeff])+i*randi([-max_numerator_coeff,max_numerator_coeff])];
	if imag(a(end))
		a=[a, conj(a(end))];
	end
end
b=[];
for jt=1:many_poles
	b=[b,randi([-max_numerator_coeff,max_numerator_coeff])+i*randi([-max_numerator_coeff,max_numerator_coeff])];
	if imag(b(end))
		b=[b, conj(b(end))];
	end
end
g1=1;
for i =1:length(a)
	g1=g1*(s-a(i));
end
for i =1:length(b)
	g1=g1/(s-b(i));
end

%{
% We can't have empty lists for the numerator or denominator
if isempty(a)
	a=1;
end
if isempty(b)
	b=1;
end
%}

% The transerfunction is created and introduced
disp('Please derive the locus for this function:')

g1
disp('It has these roots:')
disp(a)
disp('And these poles:')
disp(b)


% Now the user creates their picture. Once they are finished they press enter
% and...
x=input('Are you ready to see the solution?', 's');

% ...is displayed with equally scaled axis
rlocus(g1);
disp('Hope you made it.')

axis equal
