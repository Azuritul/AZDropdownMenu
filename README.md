# AZDropdownMenu

[![CI Status](http://img.shields.io/travis/Azuritul/AZDropdownMenu.svg?style=flat)](https://travis-ci.org/Azuritul/AZDropdownMenu)
[![Version](https://img.shields.io/cocoapods/v/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![License](https://img.shields.io/cocoapods/l/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![Platform](https://img.shields.io/cocoapods/p/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![Language](https://img.shields.io/badge/swift-2.0-orange.svg)](http://swift.org)

AZDropdownMenu is a simple dropdown menu component that supports Swift.

## Screenshots
Code used in the screencast are included in the bundled sample project.

|Default (left aligned) | Customized(with icon) |
|---|--|
|![default_menu](https://cloud.githubusercontent.com/assets/879197/12356835/074e2c16-bbe8-11e5-8edf-0f5ed40ef7c9.gif)|![custom_menu](https://cloud.githubusercontent.com/assets/879197/12356867/33af8e44-bbe8-11e5-8c5f-cd0e5f69733c.gif)|

## Usage

To run the example project, clone the repo with `git clone https://github.com/Azuritul/AZDropdownMenu.git`, and run `pod install` from the Example directory first.

## Requirements
- iOS 8 or above
- Xcode 7 or above
- Swift 2.0

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
let menu = AZDropdownMenu(titles: leftTitles )
```
Calling `public func showMenuFromView(view:UIView)` can then show the menu.

The handler `public var cellTapHandler : ((indexPath:NSIndexPath) -> Void)?` would be called
when menu item is tapped. So place code in here to do whatever you want. For example

```swift
menu.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
self?.navigationController?.pushViewController(controller, animated:true)
}
```

#### Create menu with icons
Pass in a AZDropdownMenuItemData in the initializer: `public init(dataSource:[AZDropdownMenuItemData])` and you are good to go.

> Do take a look at the sample project in this repository to get more usage of the library.

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

## Version
- 0.6.0
   - Now can use icons in the menu.
   - Added configuration options: `menuSeparatorColor`, `itemFont`
- 0.5.3
   - Now can configure item's background color while tapped

## Credit
- The icons used in the sample project are from [Glyphicons](http://www.glyphicons.com/).

## Author

Chris Wu (Azuritul), azuritul@gmail.com

## License

AZDropdownMenu is available under the MIT license. See the LICENSE file for more info.
