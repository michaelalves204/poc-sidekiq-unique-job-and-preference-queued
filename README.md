## README

### Running Redis

```bash
sudo docker run -d --name poc-redis -p 6379:6379 redis
```

### Test Script

```ruby
def queued_one_job

  x = 5

  while x > 0
    ::TestWorker.perform_async("Test")
    x = x - 1
  end
end

def queued_two_jobs

  messages = ["banana", "maçã", "uva", "banana", "banana"]

  messages.each do |message|
    puts message
    ::TestWorker.perform_async(message)
  end
end
```

## Monitoring Sidekiq Job

```
workers = Sidekiq::Workers.new.each { |process_id, thread_id, work| work}

jobs = workers.map {|worker| JSON.parse(worker[2]["payload"])}
```
