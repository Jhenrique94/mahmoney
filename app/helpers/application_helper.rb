module ApplicationHelper
  def js_from_controller(controller)
    asset = find_asset_by_env("#{controller}.js")
    javascript_include_tag(controller) if asset && asset !~ %r{^#{controller}\/}
  end

  def js_from_action(controller, action)
    asset_name = "#{controller}/#{action}"
    javascript_include_tag(asset_name) if find_asset_by_env("#{asset_name}.js")
  end

  def find_asset_by_env(file_name)
    return ::Rails.application.assets.find_asset(file_name) if Rails.env.development?
    ::Rails.application.assets_manifest.assets[file_name]
  end

  def find_precompiled_asset(file_name)
    prefix = Rails.application.config.assets.prefix
    filename = ::Rails.application.assets_manifest.assets[file_name]

    File.open(['public', prefix.delete('/'), filename].join('/')).to_a.join
  end
end
