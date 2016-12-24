# Swift-CircleMenu
A rotating circle menu written in Swift 3.

## Features 

* Gesture based rotation
* Configurable rotatability
* High customisability 
* Simple intuitive API
* Inertia effect
* Ready to use samples


## Screenshots

Swift-CircleMenu in action in [CETUS](https://itunes.apple.com/us/app/CETUS/id1174919225) iOS App.

![simulator screen shot dec 3 2016 9 17 45 pm](https://cloud.githubusercontent.com/assets/7275476/20860974/f140ce60-b99d-11e6-9f68-2178c315df1c.png)
![simulator screen shot dec 3 2016 9 17 30 pm](https://cloud.githubusercontent.com/assets/7275476/20860970/eb60b91a-b99d-11e6-95eb-1b4fa0b3670b.png)


## Getting Started

Add this to your `Podfile`:
```
pod 'Swift-CircleMenu', :git => 'https://github.com/Sufi-Al-Hussaini/Swift-CircleMenu.git'
```


## Usage

Please look at the demo project provided.

Basically, you'll need to create a circle and setup its frame & positioning, and add it to your view. 
Optionally, you may add an overlay.

Don't forget to set the `delegate` and `datasource`.

```swift
class DefaultRotatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDefaultCircleMenu()
    }
    
    func prepareDefaultCircleMenu() {
        // Create circle
        let circle = Circle(with: CGRect(x: 10, y: 90, width: 300, height: 300), numberOfSegments: 10, ringWidth: 80.0)
        // Set dataSource and delegate
        circle.dataSource = self
        circle.delegate = self
        
        // Position and customize
        circle.center = view.center
        
        // Create overlay with circle
        let overlay = CircleOverlayView(with: circle)
        
        // Add to view
        self.view.addSubview(circle)
        self.view.addSubview(overlay!)
    }

}
```

Then, you need to conform to the `CircleDelegate` and `CircleDataSource` protocols by implementing the `didMoveTo segment:` and `iconForThumbAt row:` methods.

```swift 

extension DefaultRotatingViewController: CircleDelegate, CircleDataSource {
    
    func circle(_ circle: Circle, didMoveTo segment: Int, thumb: CircleThumb) {
        let alert = UIAlertController(title: "Selected", message: "Item with tag: \(segment)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func circle(_ circle: Circle, iconForThumbAt row: Int) -> UIImage {
        return UIImage(named: "icon_arrow_up")!
    }
    
}

```
The above code will give you the default minimal circle menu shown below.

![simulator screen shot dec 3 2016 9 12 50 pm](https://cloud.githubusercontent.com/assets/7275476/20860954/9e4d5926-b99d-11e6-84c7-3dfc46ab07ea.png)

You can disable rotation using `Circle`'s optional default constructor parameter `isRotating` like so:
```swift
let circle = Circle(with: CGRect(x: 10, y: 90, width: 300, height: 300), numberOfSegments: 10, ringWidth: 80.0, isRotating: false)
```

More examples to be added soon. :)


## License

Swift-CircleMenu is licensed under the MIT license.


## Why Swift-CircleMenu?

For an app I was developing recently, I wanted something like [Android-CircleMenu](https://github.com/szugyi/Android-CircleMenu), i.e. a rotatable circle menu. 
I came across a number of circle menus for iOS on github, but only one supported rotation with inertia effect - [CDPieMenu](https://github.com/wokalski/CDPieMenu). 
The problem with CDPieMenu though, is that it is written in Obj-C and isn't being maintained currently.
So, I decided to rewrite CDPieMenu in swift and include in it all features I required in my app, and make it available publicly.


## Credits

Swift-CircleMenu is (more than) heavily inspired by [CDPieMenu](https://github.com/wokalski/CDPieMenu) - an Obj-C library written by [Wojtek Czekalski](https://github.com/wokalski). 
In its current form, this project is essentially a rewrite of CDPieMenu in Swift, with multiple bug-fixes and added features & examples. 
Special thanks to Wojtek Czekalski for his awesome CDPieMenu library!
