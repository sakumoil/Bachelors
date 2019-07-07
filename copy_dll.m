function copy_dll(handles)
       

dll_folder=uigetdir('C:\Program Files (x86)\FLIR Systems\ATS-US\sdks\file\bin','Select the directory of FLIR dlls');
list_dll=dir([dll_folder,'\*.dll']);
copyfile([dll_folder,'\*.dll'],pwd);
        
if exist([dll_folder,'\FlirMovieReaderMex.mexw64'])==2
    copyfile([dll_folder,'\FlirMovieReaderMex.mexw64'],pwd);
else
    copyfile([dll_folder,'\FlirMovieReaderMex.mexw32'],pwd);    
end
 
end