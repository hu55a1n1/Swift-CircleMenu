Pod::Spec.new do |s|
  s.name             = "Swift-CircleMenu"
  s.version          = "1.0.0"
  s.summary          = "Rotating circle menu written in Swift 3"
  s.description      = "Rotating circle menu written in Swift 3. Features include customizable rotatability & inertia effect."
  s.homepage         = "https://github.com/Sufi-Al-Hussaini/Swift-CircleMenu"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Shoaib Ahmed / Sufi-Al-Hussaini" => "sufialhussaini@gmail.com" }
  s.social_media_url = "http://shoaib-ahmed.com"
  s.source           = { :git => "https://github.com/Sufi-Al-Hussaini/Swift-CircleMenu.git", :tag => s.version }
  
  s.platforms        = { :ios => "8.0" }
  s.requires_arc     = true

  s.source_files     = 'CircleMenu/*.{swift}'

end