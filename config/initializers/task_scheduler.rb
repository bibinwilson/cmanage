require 'rufus/scheduler'  # Need this to make use of Rufus::Scheduler

require 'rubygems'   # Need this to make use of any Gem, in our case it is rufus-scheduler

require 'rake'  

Cmanage::Application.load_tasks
 # Need this to make use of Rake::Task

 #  'tempfile.rake' is the rake file I had defined under lib/tasks directory in my rails application

load File.join(Rails.root, 'lib', 'tasks', 'schedule.rake')
# 'misc.rake' is the rake file defined under railties/lib/tasks directory of the installed rails version that your application makes use of.     
#load File.join('lib', 'tasks', 'misc.rake')  
# 'misc.rake' is not required to be loaded if none of your rake tasks that you invoke are dependent on :environment task, directly or indirectly
# If this file is not loaded, you would see an error message like "Don't know how to build task :environment"
#load File.join('lib', 'tasks', 'misc.rake')  

# OPTION 1: If you want to run the scheduler as part of your very own rails process then you may adopt this option

cschedule = Rufus::Scheduler.new
ischedule = Rufus::Scheduler.new
# Making use of the syntax used in Crontab

cschedule.every '1m' do  

  task = Rake::Task["schedule:cschedule"] 

  task.reenable  # If only you do this, will your rake task run the next time you invoke it.

  task.invoke
end

ischedule.every '10m' do  

  task = Rake::Task["schedule:ischedule"] 

  task.reenable  # If only you do this, will your rake task run the next time you invoke it.

  task.invoke
end