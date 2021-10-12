function wok_gui
	f = figure('Visible', 'off');
	f.Name = 'wok_gui';
	f.ToolBar='none';
	f.Position=[0,0,540,535];
	movegui(f,'center');

	s=tf('s');
	real_of_root=1;

	split=0.2;
	hs=uipanel('Title', 'rlocus', 'Position', [0 split 1 1-split]);
	hc=uipanel('Title', 'control', 'Position', [0 0 1 split]);

	slider=uicontrol( 'Parent', hc, 'Style', 'slider');
	slider.Units='normalized';
	slider.Position=[0 0 1 1];
	slider.Min=0;
	slider.Max=2;
	slider.Value=1;
	addlistener(slider, 'Value', 'PostSet', @slider_Callback);


	fs=subplot(1,1,1,'Parent', hs);


	update();
	function slider_Callback(source, eventdata)
		real_of_root=get(eventdata.AffectedObject, 'Value');
		update();
	end

	function update()
		g1=tf(( (s+ real_of_root+1i)*(s+ real_of_root-1i) )/( s*(s+2) ) );
		rlocus(g1);
		axis equal
	end

	f.Visible='on';
end
