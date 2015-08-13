namespace :schedule do
  task :cschedule => [:environment] do
     Container.sync_container
  end
end 
