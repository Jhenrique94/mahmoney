# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')


# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile << proc do |path|
  blacklist = ['node_modules', 'gems', 'modules/', 'templates/', 'vendor/']
  @assets ||= Rails.application.assets || Sprockets::Railtie.build_environment(Rails.application)
  full_path = @assets.resolve(path)

  (path =~ %r{(^(?:(?!\/_|^_).)*$)}) && blacklist.none? { |word| !full_path.include?('fonts') && full_path.include?(word) }
end
