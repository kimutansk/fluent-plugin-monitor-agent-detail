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

```
<source>
  @type monitor_agent_detail
  bind 0.0.0.0
  port 24220
</source>
```

This configuration launches HTTP server with 24220 port and get metrics like below:

```
$ curl http://host:24220/api/plugins.json
```

## Parameters

Available parameters except @type are same as [in_monitor_agent](https://docs.fluentd.org/v1.0/articles/in_monitor_agent).

## Output Example

Show output example with following configuration:

```
<source>
  @type monitor_agent_detail
  bind 0.0.0.0
  port 24220
</source>

<source>
  @type forward
  port  24224
</source>

<match **>
  @type                forward
  @id                  forward_to_aggregation
  require_ack_response true
  <buffer tag>
    @type                       file
    path                        "/var/log/td-agent/buffer/forward_to_aggregation.*.log"
    flush_mode                  interval
    total_limit_size            10m
    flush_interval              1.0
    flush_thread_burst_interval 0.1
    flush_thread_count          1
    retry_forever               true
    retry_max_interval          30s
  </buffer>
  <server>
    name aggregation_process01
    host 127.0.0.1
    port 24321
  </server>
  <server>
    name aggregation_process02
    host 127.0.0.1
    port 24322
  </server>
</match>
```


```
{
  "plugins": [
    {
      "plugin_id": "object:3fc716c6ea54",
      "plugin_category": "input",
      "type": "monitor_agent",
      "config": {
        "@type": "monitor_agent",
        "bind": "0.0.0.0",
        "port": "24220"
      },
      "output_plugin": false,
      "retry_count": null
    },
    {
      "plugin_id": "object:3fc717453d14",
      "plugin_category": "input",
      "type": "forward",
      "config": {
        "@type": "forward",
        "port": "24224"
      },
      "output_plugin": false,
      "retry_count": null
    },
    {
      "plugin_id": "forward_to_aggregation",
      "plugin_category": "output",
      "type": "forward",
      "config": {
        "@type": "forward",
        "require_ack_response": "true"
      },
      "output_plugin": true,
      "buffer_queue_length": 3,
      "buffer_total_queued_size": 364357,
      "buffer_total_queued_ratio": 0.0347,
      "retry_count": 3,
      "retry": {}
    },
```
