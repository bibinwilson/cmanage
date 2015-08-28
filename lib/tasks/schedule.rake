namespace :schedule do
  task :cschedule => [:environment] do
     Container.sync_container
  end

  task :ischedule => [:environment] do
     Image.sync_images
  end

end 


