desc 'remove all build artifacts'
task :clean do
  dir = File.expand_path('../_site', __FILE__)
  puts "===> removing #{dir}..."
  system "rm -r #{dir}"
end

desc 'build the site'
task :build do
  puts '===> building site...'
  system 'bundle exec jekyll build'
end

desc 'rebuild site from scratch'
task rebuild: [:clean, :build]

desc 'deploy site to the webserver'
task deploy: [:build] do
  puts '===> uploading site...'
  system 'rsync -aPz --delete _site/ the-voice.cc:public_html/the-voice.cc/'
end
