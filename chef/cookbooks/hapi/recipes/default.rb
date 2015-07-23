#
# Cookbook Name:: hapi
# Recipe:: default
#

# install git
package "git" do
    action :install
end

# create source directory
directory "/src" do
    owner "vagrant"
    group "vagrant"
    mode "0755"
    action :create
end

# clone hapi source
git "/src" do
    repository "https://github.com/jamesagnew/hapi-fhir.git"
    reference "master"
    action :sync
end

# build and package hapi source
script "build" do
    interpreter "bash"
    code <<-EOH
        /usr/local/maven-*/bin/mvn clean install
        /usr/local/maven-*/bin/mvn package
        EOH
    cwd "/src"
end

# copy built .war files to tomcat
script "copy" do
    interpreter "bash"
    code <<-EOH
        cp **/target/*.war /var/lib/tomcat7/webapps
        EOH
    cwd "/src"
end
