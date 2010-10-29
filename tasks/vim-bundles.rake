namespace :vim_bundles do
	directory 'vim/doc'

	desc 'updates or installs the vim plugins specified in .vimrc'
	task :update => [:update_pathogen, :install, :update_docs] do
	end

	directory 'vim/bundle'

	task :install => 'vim/bundle' do
		uninstall_bundles = Dir['vim/bundle/*']
		bundles = YAML.load_file 'config/vim-bundles.yml'
		bundles.each do |bundle|
			dir = 'vim/bundle/' + bundle_name(bundle['url'])
			if Dir['vim/bundle/*'].include? dir
				puts "Updating #{dir}..."
				cd(dir) { `git pull` }
			else
				puts "Installing #{dir}..."
				`git clone #{bundle['url']} #{dir}`
			end
			uninstall_bundles.delete dir
		end
		uninstall_bundles.each do |dir|
			puts "Removing #{dir}..."
			rm_r dir
		end
	end

	directory 'vim/autoload'

	task :update_pathogen => 'vim/autoload' do
		unless Dir['src/*'].include? 'src/pathogen'
			puts 'Adding pathogen...'
			`git clone http://github.com/tpope/vim-pathogen.git src/pathogen`
		end

		puts 'Updating pathogen...'
		cd('src/pathogen') { `git checkout .` }
		cp 'src/pathogen/autoload/pathogen.vim', 'vim/autoload/'
	end

	def bundle_name url
		url.split('/').last.gsub(/^vim-|\.git$/, '')
	end

	directory 'vim/doc'

	task :update_docs => 'vim/doc' do
		puts 'Updating docs...'
		File.open 'vim/doc/bundles.txt', 'w' do |doc|
			doc.printf "%-32s %s %32s\n\n", "*bundles.txt*", "Bundles", "Version 0.1"
			doc.puts "These are the bundles installed on your system, along with their\n" +
				"versions and release dates.  Downloaded on #{Time.now}.\n\n" +
				"A version number of 'n/a' means upstream hasn't tagged any releases.\n"
			Dir['vim/bundle/*'].each do |bundle|
				version = date = ''
				FileUtils.cd(bundle) do
					version = `git describe --tags 2>/dev/null`.chomp
					version = "n/a" if version == ''
					date = `git log -1 --pretty=format:%ai`.chomp
				end
				doc.printf "  - %-30s %-22s %s\n", "|#{bundle}|", version, date.split(' ').first
			end
			doc.puts "\n"
			`vim -e -c "call pathogen#helptags()" -c q`
			puts "Done! In vim, type ':help bundles' to see what you installed."
		end
	end
end
