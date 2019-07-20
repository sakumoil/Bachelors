function show_results(handles,average, maximum, minimum, standard, homogeneity, entropy)


textLabel = sprintf(['mean:', blanks(1), '%.2f', blanks(1),'(%.2f - %.2f)'],average, minimum, maximum);
set(handles.text3, 'String', textLabel);
textLabel = sprintf(['standard dev.:', blanks(1), '%.2f',],standard);
set(handles.text4, 'String', textLabel);
textLabel = sprintf(['homogeneity:', blanks(1), '%.2f',],homogeneity);
set(handles.text5, 'String', textLabel);
textLabel = sprintf(['entropy', blanks(1), '%.2f',],entropy);
set(handles.text6, 'String', textLabel);

end