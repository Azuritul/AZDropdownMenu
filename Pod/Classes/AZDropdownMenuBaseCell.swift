//
//  AZDropdownMenuBaseCell.swift
//  Pods
//
//  Created by Chris Wu on 01/15/2016.
//  Copyright (c) 2016 Chris Wu. All rights reserved.
//

import Foundation

public class AZDropdownMenuBaseCell : UITableViewCell, AZDropdownMenuCellProtocol {
    
    public func configureData(data: AZDropdownMenuItemData) {
        self.textLabel?.text = data.title
    }

    func configureStyle(config: AZDropdownMenuConfig) {
        self.selectionStyle = .None
        self.backgroundColor = config.itemColor
        self.textLabel?.textColor = config.itemFontColor
        self.textLabel?.font = UIFont(name: config.itemFont, size: config.itemFontSize)

        switch config.itemAlignment {
        case .Left:
            self.textLabel?.textAlignment = .Left
        case .Right:
            self.textLabel?.textAlignment = .Right
        case .Center:
            self.textLabel?.textAlignment = .Center
        }
    }
}

protocol AZDropdownMenuCellProtocol {
    func configureData(data: AZDropdownMenuItemData)
    func configureStyle(configuration:AZDropdownMenuConfig)
}

public enum AZDropdownMenuItemAlignment {
    case Left, Right, Center
}