Dir.glob(File.expand_path "../ttt/*.rb", __FILE__) do |file|
  require file
end
