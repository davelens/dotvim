local rails = {
  routes = {},
}

function rails.present()
  return vim.fn.findfile('config.ru', '.;') ~= ''
end

-- Helper to shell out and collect your *_path / *_url helpers
function rails.load_routes()
  if not rails.present() then
    return {}
  end

  local ruby = [[
    routes = Rails.application.routes.routes.each_with_object({}) do |route, h|
      next if route.name.nil? || route.name.empty?
      helper = "#{route.name.gsub(/_nl/, '')}_path"
      next if helper.match?(/(^rails|assets)/)

      uri_pattern = route.path.spec.to_s
      next unless uri_pattern.include?('/nl') ||
        uri_pattern.include?('/backend') ||
        uri_pattern.include?('/api')

      h[helper] ||= {
        controller: route.defaults[:controller],
        action: route.defaults[:action],
        pattern: route.path.spec.to_s.gsub(/\/nl/, '')
      }
    end

    routes.each do |helper, hash| 
      puts "#{helper}||#{hash[:pattern]}||#{hash[:controller]}||#{hash[:action]}" 
    end
  ]]

  -- Can probably use vim.fn.jobstart, but we have Plenary installed anyway.
  require('plenary.job')
    :new({
      command = 'bin/rails',
      args = { 'runner', ruby },
      on_stdout = function(_, line)
        if line and line ~= '' then
          table.insert(rails.routes, line)
        end
      end,
    })
    :start()

  return rails.routes
end

return rails
