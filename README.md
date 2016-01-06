# CWDropdownMenu

[![CI Status](http://img.shields.io/travis/Azuritul/CWDropdownMenu.svg?style=flat)](https://travis-ci.org/Azuritul/CWDropdownMenu)
[![Version](https://img.shields.io/cocoapods/v/CWDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/CWDropdownMenu)
[![License](https://img.shields.io/cocoapods/l/CWDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/CWDropdownMenu)
[![Platform](https://img.shields.io/cocoapods/p/CWDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/CWDropdownMenu)

CWDropdownMenu is a simple dropdown menu component that supports Swift.

## Screenshots
Code used in the screencast are included in the bundled sample project.

![screenshot](https://cloud.githubusercontent.com/assets/879197/12143573/0654fec2-b4c5-11e5-80fd-d80f6b7df058.gif)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 8 or above
- Xcode 7 or above
- Swift 2.0

## Installation

CWDropdownMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CWDropdownMenu"
```

## Usage

Declare an array of texts that are served as the item in the menu.
```swift
let titles = ["Action 1", "Action 2", "Action 3"]

```
Then pass the array to the initializer
```swift
let menu = CWDropdownMenu(titles: leftTitles )
```
Calling `public func showMenuFromView(view:UIView)` can then show the menu.

The handler `public var cellTapHandler : ((indexPath:NSIndexPath) -> Void)?` would be called
when menu item is tapped. So place code in here to do whatever you want. For example

```swift
menu.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
self?.navigationController?.pushViewController(controller, animated:true)
}
```

Take a look at the sample project in this repository to get more usage of the library.

### Configurable options
Currently CWDropdownMenu can be customized with the following properties. More will come in the future.

- `itemHeight` Row height of the menu item. Default is 44.
- `itemColor` The color of the menu item. Default is white.
- `itemFontColor` The text color of the menu item. Default is black.
- `itemFontSize` Font size of the menu item. Default is 14.0
- `itemAlignment` The text alignment of the menu item. Default is left-aligned.
- `overlayAlpha` The transparency for the background overlay. Default is 0.5
- `overlayColor` Color for the background overlay. Default is black.
- `menuSeparatorStyle` The separator of the menu. Default is single line.


## Author

Chris Wu (Azuritul), azuritul@gmail.com

## License

CWDropdownMenu is available under the MIT license. See the LICENSE file for more info.
