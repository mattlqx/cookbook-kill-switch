#
# Cookbook:: kill-switch
# Recipe:: default
#
# Copyright 2017, Matt Kulka
#

reason = nil
if node['kill_switch']['engage']
  reason = "node attribute ['kill_switch']['engage']"
elsif File.exist?(node['kill_switch']['touch_file'])
  reason = "touch file #{node['kill_switch']['touch_file']}"
else
  return
end

if node['kill_switch']['normal_exit']
  Chef::Application.fatal!(
    "Kill switch has been engaged (#{reason}). Aborting run with clean exit.",
    Chef::Application::ExitCode::VALID_RFC_062_EXIT_CODES[:SUCCESS]
  )
else
  Chef::Application.fatal!("Kill switch has been engaged (#{reason}). Aborting run with dirty fatal.")
end
