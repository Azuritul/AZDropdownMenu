# AZDropdownMenu

[![Build Status](https://www.bitrise.io/app/1dcd88cfb9a0f14e.svg?token=-Rs7yi0wHvWCFAZzx977JA)](https://www.bitrise.io/app/1dcd88cfb9a0f14e)
[![Version](https://img.shields.io/cocoapods/v/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![License](https://img.shields.io/cocoapods/l/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![Platform](https://img.shields.io/cocoapods/p/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![Language](https://img.shields.io/badge/swift-3-orange.svg)](http://swift.org)

AZDropdownMenu is a simple dropdown menu component that supports Swift.

## Screenshots
Code used in the screencast are included in the bundled sample project.

![screencast](https://cloud.githubusercontent.com/assets/879197/13528338/455c738a-e250-11e5-8671-312aa58a63e1.gif)

## Demo Project

To run the demo project, clone the repo with `git clone https://github.com/Azuritul/AZDropdownMenu.git`, and run `pod install` from the Example directory first.

## Requirements
- iOS 8 or above
- Xcode 8 or above
- Swift 3

## Installation

AZDropdownMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
use_frameworks!
pod 'AZDropdownMenu'
```

## Usage

Declare an array of texts that are served as the item in the menu.
```swift
let titles = ["Action 1", "Action 2", "Action 3"]
```
Then pass the array to the initializer
```swift
let menu = AZDropdownMenu(titles: titles)
```

Set up so that the `UIBarButtonItem` is asso



ated with a function that shows the menu
```
let button = UIBarButtonItem(image: UIImage(named: "menu_image"), style: .Plain, target: self, action: "showDropdown")
navigationItem.leftBarButtonItem = menuButton
```

Calling `public func showMenuFromView(view:UIView)` can then show the menu.
```swift
func showDropdown() {
    if (self.menu?.isDescendantOfView(self.view) == true) {
        self.menu?.hideMenu()
    } else {
        self.menu?.showMenuFromView(self.view)
    }
}
```

The handler `public var cellTapHandler : ((indexPath:NSIndexPath) -> Void)?` would be called
when menu item is tapped. So place code in here to do whatever you want. For example

```swift
menu.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
    self?.navigationController?.pushViewController(controller, animated:true)
}
```

#### Create menu with icons
Pass in a AZDropdownMenuItemData in the initializer: `public init(dataSource:[AZDropdownMenuItemData])` and you are good to go.

> Take a look at the sample project in this repository to get more usage of the library.

### Configurable options
Currently AZDropdownMenu can be customized with the following properties. More will come in the future.

- `itemHeight` Row height of the menu item. Default is 44.
- `itemColor` The background color of the menu item. Default is white.
- `itemFontColor` The text color of the menu item. Default is black.
- `itemFontSize` Font size of the menu item. Default is 14.0
- `itemFont` Font used in the menu. Default is 'Helvetica'
- `itemAlignment` The alignment of the menu item. Default is left-aligned.
- `itemSelectionColor` The background color of the menu item while it is tapped. Default is gray.
- `overlayAlpha` The transparency for the background overlay. Default is 0.5
- `overlayColor` Color for the background overlay. Default is black.
- `menuSeparatorStyle` The separator of the menu. Default is single line.
- `menuSeparatorColor` The color of the separator. Default is light gray.
- `itemImagePosition` The position of image in the menu. Can be positioned before or after the text. Default is `.Prefix`.
- `shouldDismissMenuOnDrag` If set to true, menu would be dismissed on drag. Default value is `false`.

## Version
- 1.1.3
   - Update for Swift 4 syntax
   
- 1.1.2
   - Update for Swift 3 syntax

- 1.1.1
   - Update for Swift 2.2's #selector syntax

- 1.1.0
   - Added `shouldDismissMenuOnDrag` option, menu would be dismissed on drag if this option is enabled
   - Modified the sample project with an example using `UITableView`.
   - Added gesture handler for the menu.
   - Extract config struct to a separate file
   - Update readme.
- 1.0.0
   - Added `itemImagePosition` option, now can configure the icon position.
   - Changed icon sets and its corresponding location in the sample project.
   - Modified sample project's appearance a little bit.
   - Modified sample project's structure.
   - Added CHANGELOG.md
- 0.6.1
   - Update readme
- 0.6.0
   - Now can use icons in the menu.
   - Added configuration options: `menuSeparatorColor`, `itemFont`
- 0.5.3
   - Now can configure item's background color while tapped

## Credit
- Icon used in in the sample project is [Designed by Skydesign - Freepik.com](http://www.freepik.com/free-photos-vectors/people)

## Author
Chris Wu (Azuritul), azuritul@gmail.com

## License
AZDropdownMenu is available under the MIT license. See the LICENSE file for more info.
