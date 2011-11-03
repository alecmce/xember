require "fileutils"
require "buildr/as3" # needs buildr-as3 v0.2.29.pre

# You can use bundler to install the correct buildr gem: bundle install
# Then you can run buildr isolated: bundle exec buildr [tasks] ...

repositories.remote << "http://artifacts.devboy.org" << "http://repo2.maven.org/maven2"

THIS_VERSION = "0.1.0-SNAPSHOT"

define "xember" do

  project.group = "xember"
  project.version = THIS_VERSION

  as3_layout = Layout::Default.new
  as3_layout[:source, :main, :as3] = "src"
  as3_layout[:source, :test, :as3] = "test"

  define "as3", :layout => as3_layout do 

	  compile.using( :compc, :flexsdk => flexsdk ).
	  	with( _(:libs,"as3-signals.swc"),
	  				_(:libs,"robotlegs-framework-v1.4.0.swc") )

	  #testing needs to be added, asunit4 needs to report to the flexunint4 listener

	  doc_title = "Xember v#{THIS_VERSION}"
	  doc.using :maintitle   => doc_title,
	            :windowtitle => doc_title

	  package :swc
  end

end

def flexsdk
  @flexsdk ||= begin
    # should be using the flex sdk version from user.properties (if it exists) or environment
    flexsdk = FlexSDK.new("4.1.0.16076")
    flexsdk.default_options << "-keep-as3-metadata+=Inject" << "-keep-as3-metadata+=PostConstruct"
    flexsdk
  end
end
