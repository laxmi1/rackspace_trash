require 'rdoc/task'

#task :clean do
#    system "ruby -rubygems resetdb.rb"
#end

task :sst, [:suite, :test_name] do |t, args|

    if args.suite
      if File.exist?("trash_code/#{args.suite}.rb")
        folder_name = 'trash_code'
      end
      suite = args.suite
          if args.test_name
            system "ruby -rubygems #{folder_name}/#{suite}.rb --name test_#{args.test_name} >> #{folder_name}_output.log"
          else
            system "ruby -rubygems #{folder_name}/#{suite}.rb >> #{folder_name}_output.log"
          end
    else
        Dir.glob('trash_code/*.rb') do |file|
            suite = File.basename file
            system "ruby -rubygems trash_code/#{suite} >>  smoke_test_output.log"
        end
      end
    system "ruby -rubygems suite_status.rb"    
end
