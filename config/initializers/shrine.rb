if Rails.env.test?
  require "shrine/storage/memory"

  Shrine.storages = {
      cache: Shrine::Storage::Memory.new,
      store: Shrine::Storage::Memory.new
  }
else
  require "shrine/storage/file_system"

  Shrine.storages = {
      cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
      store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store")
  }
end

Shrine.plugin :activerecord
Shrine.plugin :determine_mime_type
Shrine.plugin :validation
Shrine.plugin :validation_helpers
Shrine.plugin :derivatives, create_on_promote: true
Shrine.plugin :upload_options, cache: { move: true }, store: { move: true }
