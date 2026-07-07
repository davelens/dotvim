local docker = {}

-- Asynchronously checks whether a named docker container is running.
-- `callback(is_running)` is invoked with a boolean once the check completes.
-- Using vim.system keeps this off the main thread so BufEnter never blocks.
function docker.container_running(name, callback)
  vim.system(
    { 'utility', 'docker', 'check', name },
    { text = true },
    function(result)
      callback(result.code == 0)
    end
  )
end

return docker
