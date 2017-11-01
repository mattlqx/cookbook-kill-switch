default['kill_switch']['engage'] = false
default['kill_switch']['normal_exit'] = false
default['kill_switch']['touch_dir'] = case node['os']
                                      when 'windows'
                                        'C:'
                                      end
default['kill_switch']['touch_file'] = File.join(node['kill_switch']['touch_dir'].to_s, '.kill_chef')
