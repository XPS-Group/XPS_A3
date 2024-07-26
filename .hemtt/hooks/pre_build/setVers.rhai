let modcpp = HEMTT_VFS.join("mod.cpp").open_file().read(); 
modcpp.replace("[0.0.0]", HEMTT.project().version().to_string_short()); 
HEMTT_VFS.join("mod.cpp").create_file().write(modcpp); 

let versTxt = HEMTT_VFS.join("version.txt").open_file().read(); 
versTxt.replace("[0.0.0]", HEMTT.project().version().to_string_short()); 
versTxt.replace("[DATE]", date("[year]-[month]-[day]")); 
versTxt.replace("[000000]", date("[year repr:last_two][month][day]")); 
HEMTT_VFS.join("version.txt").create_file().write(versTxt); 

let svhpp = HEMTT_VFS.join("addons").join("main").join("script_version.hpp").open_file().read(); 
svhpp.replace("[000000]", date("[year repr:last_two][month][day]")); 
HEMTT_VFS.join("addons").join("main").join("script_version.hpp").create_file().write(svhpp); 