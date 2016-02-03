# RiakPoolerIssue

## To Reproduce

Run this and there should be no errors:

    iex -S mix
    iex> RiakPoolerIssue.spawn_concurrent_requests(5)

Run this and you will get 5 exceptions:

    iex -S mix
    iex> RiakPoolerIssue.spawn_concurrent_requests(10)

They look like this:

```
21:03:45.777 [error] Process #PID<0.192.0> raised an exception
** (FunctionClauseError) no function clause matching in Riak.find/4
    (riak) lib/riak.ex:301: Riak.find(:error_no_members, :error_no_members, "abc", "def")
    (riak) lib/riak.ex:301: Riak.find/3
    (riak) lib/riak.ex:282: Riak.find/2
```

Run this again and it will work without exceptions:

    iex> RiakPoolerIssue.spawn_concurrent_requests(10)

## Explanation

It seems like, when you exceed the minimum number concurrent of pools,
connections _are_ lazily allocated, but the first request for each connection
fails. The workaround is to set `max_count` equal to `init_count`, but that
defeats the purpose of a growing pool.

At a minimum, it would be nice if the client would throw a nicer error or
return a pattern to match against such that I could handle this at a higher
level. As it is, the error that's thrown isn't very clean. And even with
`init_count` = `max_count`, if you exceed that concurrency, we'll end up with a
messy exception to deal with.

Ideally, it would be great if the client would automatically retry once on
`:error_no_members`, since this would fix the growing pool problem and would
also help with a class of errors where you exceed the max concurrency; unless
you're consistently above max concurrency, a retry will often succeed.
