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
