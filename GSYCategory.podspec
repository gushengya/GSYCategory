Pod::Spec.new do |s|

    s.name         = "GSYCategory"
    s.version      = "1.0.3"
    s.summary      = "通用分类."
    s.description  = <<-DESC
    OC项目通用的分类文件集合.
                   DESC
    s.platform     = :ios, '9.0'
    s.homepage     = "https://github.com/gushengya/GSYCategory"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author             = { "gushengya" => "759705236@qq.com" }
    s.source       = { :git => "https://github.com/gushengya/GSYCategory.git", :tag => "#{s.version}" }
    s.source_files  = "GSYExtension/**/*.{h,m}"
    s.frameworks = 'UIKit'
  
end