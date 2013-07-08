task :user => :environment do
  puts "Hello!"
end



# This is needed because the existing version of directory in Rake
# is slightly broken, but Jim says it'll be fixed in the next version.
alias :original_directory :directory
def directory(dir)
  original_directory dir
  Rake::Task[dir]
end

# Do the directory creation
namespace :utils do
  task :create_directories => [
      directory('public/icons'),
      directory('public/images'),
      directory('public/groups'),
  ]
end