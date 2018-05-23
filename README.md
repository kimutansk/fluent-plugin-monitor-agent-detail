# fluent-plugin-monitor-agent-detail

[Fluentd](http://fluentd.org) plugin to monitor executing Fluentd plugins based [in_monitor_agent](https://docs.fluentd.org/v1.0/articles/in_monitor_agent) plugin.
This plugin outputs below additional informations compared with in_monitor_agent.

- buffer_total_queued_ratio
  - Calculated ratio (buffer_total_queued_size / total_limit_size)

## Requirements

| fluentd    | ruby   |
|------------|--------|
| >= v0.14.0 | >= 2.1 |

## Example Configuration



## Parameters

Available parameters except @type are same as [in_monitor_agent](https://docs.fluentd.org/v1.0/articles/in_monitor_agent).

## Output Example

