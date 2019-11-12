# frozen_string_literal: true

def reboot_scheduled?
  case node['platform']
  when 'ubuntu'
    if node['platform_version'].to_i >= 16
      cmd = Mixlib::ShellOut.new('busctl get-property org.freedesktop.login1 /org/freedesktop/login1 ' \
                                 'org.freedesktop.login1.Manager ScheduledShutdown')
      cmd.run_command
      return cmd.exitstatus == 0 && (cmd.stdout.include?('"poweroff"') || cmd.stdout.include?('"reboot"'))
    end
  end
  false
end
