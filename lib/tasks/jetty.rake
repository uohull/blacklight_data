# Note: These rake tasks are here mainly as examples to follow. You're going to want
# to write your own rake tasks that use the locations of your jetty instances. 

require 'jettywrapper'

namespace :jetty do

  desc "Init BlacklightData configuration" 
  task :init => [:environment] do
    if !ENV["environment"].nil? 
      RAILS_ENV = ENV["environment"]
    end
    
    JETTY_HOME = File.expand_path(File.dirname(__FILE__) + '/../../jetty')
    
    JETTY_PARAMS = {
      :quiet => ENV['HYDRA_CONSOLE'] ? false : true,
      :jetty_home => JETTY_HOME,
      :jetty_port => 8983,
      :solr_home => File.expand_path(JETTY_HOME + '/solr'),
    }

  end

  desc "Copies the default SOLR config for the bundled jetty"
  task :config_solr => [:init] do
    FileList['solr/conf/*'].each do |f|  
      cp("#{f}", JETTY_PARAMS[:solr_home] + '/blacklight-core/conf/', :verbose => true)
      #cp("#{f}", JETTY_PARAMS[:solr_home] + '/test-core/conf/', :verbose => true)
    end
  end

end