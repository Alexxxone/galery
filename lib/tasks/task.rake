task :user => :environment do
  require 'io/console'
  puts "please input folder dislocation"
  puts "default : /home/user3/WORK/faceit/galery/pic_dir"
  pa = STDIN.gets.chomp
  Dir.chdir(pa) do |dir|
    Dir.open(dir)
    if File.directory?(dir)
      folder = Dir.glob("*")
      folder.each do |category|
        Dir.foreach(category) {| file |
          if file.length >=3
            save(file,category)
          end
        }
  end
 end
end
end
def save(file,category)
  @cat = Category.find_or_create_by_name(:name=>category)
  @pic = @cat.pictures.create(:title=>file,:filename=>File.open("#{pwd}/#{category}/#{file.to_s}"))
end
