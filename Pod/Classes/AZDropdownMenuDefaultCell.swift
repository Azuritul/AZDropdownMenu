//
//  AZDropdownMenuDefaultCell.swift
//  Pods
//
//  Created by Chris Wu on 01/12/2016.
//  Copyright (c) 2016 Chris Wu. All rights reserved.
//

import UIKit
import Foundation

public final class AZDropdownMenuDefaultCell: AZDropdownMenuBaseCell {

    /// Container that encloses everything
    fileprivate let container = UIView()

    /// Container that wraps the icon and the text
    fileprivate let innerContainer = UIView()
    fileprivate let iconView = UIImageView ()
    fileprivate let titleLabel = UILabel()
    fileprivate var isSetupFinished = false
    fileprivate var config : AZDropdownMenuConfig

    init(reuseIdentifier: String?, config: AZDropdownMenuConfig) {
        self.config = config
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        container.translatesAutoresizingMaskIntoConstraints = false
        innerContainer.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        innerContainer.addSubview(titleLabel)
        innerContainer.addSubview(iconView)

        container.addSubview(innerContainer)
        self.contentView.addSubview(container)
        setupForDefaultLayout()
    }

    init(style: UITableViewCellStyle, reuseIdentifier: String?, config: AZDropdownMenuConfig) {
        self.config = config
        super.init(style:.default, reuseIdentifier: reuseIdentifier)
    }
    
    public override func updateConstraints() {
        super.updateConstraints()
        self.setupForDefaultLayout()
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func constraintsForLeftAlignment(_ viewBindings: [String:AnyObject]) -> [NSLayoutConstraint] {
        switch config.itemImagePosition {
            case .prefix:
                return NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[icon]-10-[title]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
            case .postfix:
                return NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[title]-10-[icon]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
        }
        
    }

    fileprivate func constraintsForRightAlignment(_ viewBindings: [String:AnyObject]) -> [NSLayoutConstraint] {
        switch config.itemImagePosition {
        case .prefix:
            return NSLayoutConstraint.constraints(withVisualFormat: "H:[title]-10-[icon]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
        case .postfix:
            return NSLayoutConstraint.constraints(withVisualFormat: "H:[title]-10-[icon]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
        }
        
        
    }

    fileprivate func constraintsForCenterAlignment(_ viewBindings: [String:AnyObject]) -> [NSLayoutConstraint] {
        var constraints:[NSLayoutConstraint]
        switch config.itemImagePosition {
            case .prefix:
                constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[icon]-10-[title]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
            case .postfix:
                constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[title]-10-[icon]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
        }
        
        
        let innerCenterX = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: innerContainer, attribute: .centerX, multiplier: 1, constant: 0)
        constraints.append(innerCenterX)
        return constraints
    }
    
    public func setupForDefaultLayout() {

        if (!self.isSetupFinished) {

            let bindings = ["container": container, "icon": iconView, "title": titleLabel, "inner": innerContainer]

            var constraintsForAlignment = [NSLayoutConstraint]()
            switch (self.config.itemAlignment) {
            case .left:
                constraintsForAlignment = constraintsForLeftAlignment(bindings)
            case .right:
                constraintsForAlignment = constraintsForRightAlignment(bindings)
            case .center:
                constraintsForAlignment = constraintsForCenterAlignment(bindings)
            }

            /// Icon and title should be always vertically centered
            let iconCenterY = NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: innerContainer, attribute: .centerY, multiplier: 1, constant: 0)
            let titleCenterY = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: innerContainer, attribute: .centerY, multiplier: 1, constant: 0)

            let innerContainerHAlignment = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[inner]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings)
            let innerContainerVAlignment = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[inner]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings)

            /// Constraints for outermost container, should always stretch to superview
            let width = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[container]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings)
            let height = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[container]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings)

            innerContainer.addConstraints(constraintsForAlignment)
            innerContainer.addConstraint(iconCenterY)
            innerContainer.addConstraint(titleCenterY)
            container.addConstraints(innerContainerHAlignment)
            container.addConstraints(innerContainerVAlignment)
            contentView.addConstraints(width)
            contentView.addConstraints(height)

            isSetupFinished = true
        }
    }

    public override func configureData(_ item: AZDropdownMenuItemData) {
        self.titleLabel.text = item.title
        if let icon = item.icon {
            self.iconView.image = icon
        }
    }

    override func configureStyle(_ config: AZDropdownMenuConfig) {
        self.selectionStyle = .none
        self.backgroundColor = config.itemColor
        self.titleLabel.textColor = config.itemFontColor
        self.titleLabel.font = UIFont(name: config.itemFont, size: config.itemFontSize)

        switch config.itemAlignment {
        case .left:
            self.titleLabel.textAlignment = .left
        case .right:
            self.titleLabel.textAlignment = .right
        case .center:
            self.titleLabel.textAlignment = .center
        }
    }
    
}


