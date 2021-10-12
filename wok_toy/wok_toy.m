% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%- This function creates a GUI, which lets the user interact with a root locus
% analysis by moving a complex pair of roots from side to side.
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function wok_gui
	% create an invisible figure. It is set to visible after all the elements
	%  have been created. Additional parameters are set and the window is moved to
	%  the center of the screen.
	f = figure('Visible', 'off');
	f.Name = 'wok_gui';
	f.ToolBar='none';
	f.Position=[0,0,540,535];
	movegui(f,'center');

	% These are the internal variables.
	% The transferfunction s allows for the creation of transferfunctions later
	%   in the update() function. 
	% 'real_of_root' is the user variable value or the real value of the roots.
	s=tf('s');
	real_of_root=1;

	% panels which are meant to house the plot and the control slider
	split=0.2;
	hs=uipanel('Title', 'rlocus', 'Position', [0 split 1 1-split]);
	hc=uipanel('Title', 'control', 'Position', [0 0 1 split]);

	% control slider
	slider=uicontrol( 'Parent', hc, 'Style', 'slider');
	slider.Units='normalized';
	slider.Position=[0 0 1 1];
	slider.Min=0;
	slider.Max=2;
	slider.Value=1;
	addlistener(slider, 'Value', 'PostSet', @slider_Callback);


	% plot
	fs=subplot(1,1,1,'Parent', hs);


	% After the initialization is done the update() function is called, so that
	% the initail plot is shown
	update();
	% The slider_Callback is called whenever the slider is moved
	function slider_Callback(source, eventdata)
		real_of_root=get(eventdata.AffectedObject, 'Value');
		update();
	end

	% the update function is called to update the plot
	function update()
		g1=tf(( (s+ real_of_root+1i)*(s+ real_of_root-1i) )/( s*(s+2) ) );
		rlocus(g1);
		axis equal
	end

	f.Visible='on';
end
