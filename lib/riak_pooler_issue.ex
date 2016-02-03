defmodule RiakPoolerIssue do
  def spawn_concurrent_requests(n) do
    Enum.map 1..n, fn(_) ->
      spawn fn ->
        Riak.find("abc", "def")
      end
    end
  end
end
