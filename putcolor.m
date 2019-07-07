function putcolor(handles,color_id)

axes(handles.axes1);
if color_id==1
   colormap(gca,gray); 
end
if color_id==2
   colormap(gca,jet); 
end
if color_id==3
   colormap(gca,hot); 
end

if color_id==4
   colormap(gca,parula); 
end

if color_id==5
   colormap(gca,cool); 
end

if color_id==6
   colormap(gca,summer); 
end

end

