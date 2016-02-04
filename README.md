# AZDropdownMenu

[![CI Status](http://img.shields.io/travis/Azuritul/AZDropdownMenu.svg?style=flat)](https://travis-ci.org/Azuritul/AZDropdownMenu)
[![Version](https://img.shields.io/cocoapods/v/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![License](https://img.shields.io/cocoapods/l/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![Platform](https://img.shields.io/cocoapods/p/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![Language](https://img.shields.io/badge/swift-2.0-orange.svg)](http://swift.org)

AZDropdownMenu is a simple dropdown menu component that supports Swift.

## Screenshots
Code used in the screencast are included in the bundled sample project.

![cast](https://cloud.githubusercontent.com/assets/879197/12817575/0734865e-cb96-11e5-8b90-d3e0cea18164.gif)

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
- `itemImagePosition` The position of image in the menu. Can be positioned before or after the text. Default is `.Prefix`.


## Version
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

## Contribute
1. Fork the repo
2. Create your own branch with names that are easy to understand, e.g: `feature/xxx-feature`
3. Commit changes
4. Push branch to origin or whatever repo your name is: `git push origin feature/xxx-feature`
5. Submit a pull request, compare against `develop` branch in the upstream repo and ensure there is no conflict between the two.

## License
AZDropdownMenu is available under the MIT license. See the LICENSE file for more info.
