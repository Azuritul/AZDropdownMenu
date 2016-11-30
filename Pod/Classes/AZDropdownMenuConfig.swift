//
//  AZDropdownMenuConfig.swift
//  AZDropdownMenu
//
//  Created by Chris Wu on 2016/3/3.
//  Copyright (c) 2016 Chris Wu. All rights reserved.
//

import Foundation


struct AZDropdownMenuConfig {
    
    var itemColor : UIColor = UIColor.white
    var itemSelectionColor : UIColor = UIColor.lightGray
    var itemAlignment : AZDropdownMenuItemAlignment = .Left
    var itemFontColor : UIColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
    var itemFontSize : CGFloat = 14.0
    var itemFont : String = "Helvetica"
    var overlayAlpha : CGFloat = 0.5
    var overlayColor : UIColor = UIColor.black
    var menuSeparatorStyle : AZDropdownMenuSeperatorStyle = .Singleline
    var menuSeparatorColor : UIColor = UIColor.lightGray
    var itemImagePosition : AZDropdownMenuItemImagePosition = .Prefix
    var shouldDismissMenuOnDrag : Bool = false
}

/**
 The separator style of the menu
 
 - Singleline: A solid single line
 - None:       No Separator
 */
public enum AZDropdownMenuSeperatorStyle {
    case Singleline, None
}

/**
 The position of image icon in the menu
 
 - Prefix:  Place icon before item title
 - Postfix: Place icon after item title
 */
public enum AZDropdownMenuItemImagePosition {
    case Prefix, Postfix
}
