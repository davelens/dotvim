local docker = {}

function docker.container_running(name)
  local cmd = string.format('utility docker check %s', name)
  vim.fn.system(cmd)
  return vim.v.shell_error == 0
end

return docker
