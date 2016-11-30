//
//  AZDropdownMenuBaseCell.swift
//  Pods
//
//  Created by Chris Wu on 01/15/2016.
//  Copyright (c) 2016 Chris Wu. All rights reserved.
//

import Foundation

open class AZDropdownMenuBaseCell : UITableViewCell, AZDropdownMenuCellProtocol {
    
    open func configureData(_ data: AZDropdownMenuItemData) {
        self.textLabel?.text = data.title
    }

    func configureStyle(_ config: AZDropdownMenuConfig) {
        self.selectionStyle = .none
        self.backgroundColor = config.itemColor
        self.textLabel?.textColor = config.itemFontColor
        self.textLabel?.font = UIFont(name: config.itemFont, size: config.itemFontSize)

        switch config.itemAlignment {
        case .left:
            self.textLabel?.textAlignment = .left
        case .right:
            self.textLabel?.textAlignment = .right
        case .center:
            self.textLabel?.textAlignment = .center
        }
    }
}

protocol AZDropdownMenuCellProtocol {
    func configureData(_ data: AZDropdownMenuItemData)
    func configureStyle(_ configuration:AZDropdownMenuConfig)
}

public enum AZDropdownMenuItemAlignment {
    case left, right, center
}
