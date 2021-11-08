RSpec.configure do |config|
  config.before(:suite) do
    Searchkick.disable_callbacks
  end

  config.before(:all, search: true) do
    Photographer.reindex
    Photo.reindex
  end

  config.around(:each, search: true) do |example|
    Searchkick.callbacks(nil) do
      example.run
    end
  end
end
