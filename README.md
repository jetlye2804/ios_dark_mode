# iOS Dark Mode

This iOS Dark Mode Project contains two view controllers - A main view controller to display the current apperance, and another modal view controller for settings.

## What this app can do?
1. Provides three type of settings in UITableView - Manual Light mode that makes the whole app in light appearance, Manual Dark mode that makes the whole app in dark appearance, and system-wide mode to follow the devices appearance.
2. Store user settings via UserDefaults, so that the chosen appearance will be stored even though the app is "killed"
3. Show text "Light", "Dark" or "System" based on the chosen appearance.

## How does it work?
1. Using self-defined `UIWindow.key` to override the appearance for the whole app, instead of only one UIViewController

```
extension UIWindow {
    static var key: UIWindow? {
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
    }
}

// Under the viewDidLoad function:
if let window = UIWindow.key{
    // code segment
}
```

2. Find a key named `dark_mode` from `UserDefaults.standard` and read its' value. Possible value are `"Light"`, `"Dark"` and `"System"`.

3. Using `window.overrideUserInterfaceStyle` to override the appearance:<br>
a. `.light` makes the whole app mandate to be light mode<br>
b. `.dark` makes the whole app mandate to be dark mode<br>
c. `.unspecified` makes the whole app follow the system settings

4. In the modal view with UITableView, `UserDefault.standard`'s key (`dark_mode`) will be read, and based on the value, the table cell accessory will be set as `.checkmark` (if the options matches the value) or `.none`

```
let mode = ["Light", "Dark", "System"]
//...
if(defaults.string(forKey: "dark_mode") == "Light"){
    if (mode[indexPath.row] == "Light"){
        cell.accessoryType = .checkmark
    }
    else{
        cell.accessoryType = .none
    }
}
```

5. When choosing a mode from the table cell, the `window.overrideUserInterfaceStyle` will be triggered again to override the whole app appearance, and set a new value under the `dark_mode` key from `UserDefaults.standard`.

6. `UIView.transition` is used to make the changing has smooth transition effect.
```
if let window = UIWindow.key{
    UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
        window.overrideUserInterfaceStyle = .dark
    }, completion: nil)
}
```

## Language and framework
It's purely Swift (sorry but Objective-C), and using Storyboard (UIKit). I will create another project for purely SwiftUI in the future.

## Startup
Just clone the whole repository into your local computer. You are recommended to use Xcode 13 and above. The minimum deployment version is iOS 15.0 and iPadOS 15.0.


