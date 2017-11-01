# kill-switch

This cookbook allows you a quick and easy way to stop Chef runs in your environment either through a touch file on the filesystem or through a node attribute. You also have the choice of a clean or unclean exit.

The exit logic occurs during the compilation phase. This recipe should be included at the very tippy top of your run_list to ensure other compilation phase actions do not run.

You should absolutely use this functionality sparingly. Converging a node on a routine basis prevents configuration drift and the longer you go without running Chef, the more risk you take from more changes being introduced to the system on the next run. There are however use-cases and emergency situations where you need to shut-down Chef runs on a tier of servers or even globally for a period of time. This cookbook aims to be a tool that can be leveraged for those scenarios.

There is some monkey-patching that needs to happen to have the option of a clean exit during compilation. No refunds, sorry.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['kill_switch']['engage']</tt></td>
    <td>Bool</td>
    <td>Force Chef run to exit immediately.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kill_switch']['normal_exit']</tt></td>
    <td>Bool</td>
    <td>Exit should be "success" / `0`. Will still generate a `fatal` level log message regardless.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['kill_switch']['touch_file']</tt></td>
    <td>String</td>
    <td>Engage kill switch if a file exists at this path</td>
    <td><tt>C:\\.kill_chef</tt> on Windows, <tt>/.kill_chef</tt> on Linux</td>
  </tr>
</table>

## Recipes

### kill-switch::default

Checks for a touch file or `node['kill_switch']['engage']` to be `true` and exits the Chef run immediately with desired exit status.

## License and Authors

Authors: Matt Kulka <matt@lqx.net>
