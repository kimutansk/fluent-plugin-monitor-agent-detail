#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
require 'json'
require "net/http"
require 'uri'

class MaxQueuedRatioGetter

    def initialize(host, port)
        @host = host
        @port = port
    end

    def get_max_queued_ratio()
        url = URI.parse("http://#{@host}:#{@port}")
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.get("/api/plugins.json")
        }
        response = JSON.parse(res.body)

        max_queued_ratio = 0.0
        if response.has_key?("plugins")
            response["plugins"].each {|plugin|
                if plugin.has_key?("buffer_total_queued_ratio")
                    if max_queued_ratio < plugin["buffer_total_queued_ratio"]
                        max_queued_ratio = plugin["buffer_total_queued_ratio"]
                    end
                end
            }
        end

        max_queued_ratio
    end
end

if __FILE__ == $0
    if ARGV.size < 2
        puts "Usage: ruby get_max_queued_ratio.rb [host] [port]"
        exit(1)
    end

    instance = MaxQueuedRatioGetter.new(ARGV[0], ARGV[1])
    puts instance.get_max_queued_ratio()
end
