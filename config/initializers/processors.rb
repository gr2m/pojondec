UPLOAD_PROCESSORS = []

Dir.entries("app/models/processors").each do |entry|
  next if entry =~ /^\./
  name = File.basename(entry, '.*').camelize
  UPLOAD_PROCESSORS.push name
end