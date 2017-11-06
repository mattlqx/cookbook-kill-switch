name 'kill-switch'
maintainer 'Matt Kulka'
maintainer_email 'matt@lqx.net'
license 'MIT'
description 'Kill switch to prevent Chef runs from occuring'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.1'
chef_version '>= 12.1' if respond_to?(:chef_version)

%w[ubuntu debian fedora centos redhat oracle scientific amazon freebsd openbsd mac_os_x solaris2 opensuse opensuseleap
   suse windows].each do |os|
  supports os if respond_to?(:supports)
end

source_url 'https://github.com/mattlqx/cookbook-kill-switch' if respond_to?(:source_url)
issues_url 'https://github.com/mattlqx/cookbook-kill-switch/issues' if respond_to?(:issues_url)
