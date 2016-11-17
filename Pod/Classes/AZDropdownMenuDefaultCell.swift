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
    private let container = UIView()

    /// Container that wraps the icon and the text
    private let innerContainer = UIView()
    private let iconView = UIImageView ()
    private let titleLabel = UILabel()
    private var isSetupFinished = false
    private var config : AZDropdownMenuConfig

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

    private func constraintsForLeftAlignment(viewBindings: [String:AnyObject]) -> [NSLayoutConstraint] {
        switch config.itemImagePosition {
            case .Prefix:
                return NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[icon]-10-[title]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
            case .Postfix:
                return NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[title]-10-[icon]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
        }
        
    }

    private func constraintsForRightAlignment(viewBindings: [String:AnyObject]) -> [NSLayoutConstraint] {
        switch config.itemImagePosition {
        case .Prefix:
            return NSLayoutConstraint.constraints(withVisualFormat: "H:[title]-10-[icon]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
        case .Postfix:
            return NSLayoutConstraint.constraints(withVisualFormat: "H:[title]-10-[icon]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
        }
        
        
    }

    private func constraintsForCenterAlignment(viewBindings: [String:AnyObject]) -> [NSLayoutConstraint] {
        var constraints:[NSLayoutConstraint]
        switch config.itemImagePosition {
            case .Prefix:
                constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[icon]-10-[title]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewBindings)
            case .Postfix:
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
            case .Left:
                constraintsForAlignment = constraintsForLeftAlignment(viewBindings: bindings)
            case .Right:
                constraintsForAlignment = constraintsForRightAlignment(viewBindings: bindings)
            case .Center:
                constraintsForAlignment = constraintsForCenterAlignment(viewBindings: bindings)
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

    public override func configureData(data item: AZDropdownMenuItemData) {
        self.titleLabel.text = item.title
        if let icon = item.icon {
            self.iconView.image = icon
        }
    }

    override func configureStyle(configuration config: AZDropdownMenuConfig) {
        self.selectionStyle = .none
        self.backgroundColor = config.itemColor
        self.titleLabel.textColor = config.itemFontColor
        self.titleLabel.font = UIFont(name: config.itemFont, size: config.itemFontSize)

        switch config.itemAlignment {
        case .Left:
            self.titleLabel.textAlignment = .left
        case .Right:
            self.titleLabel.textAlignment = .right
        case .Center:
            self.titleLabel.textAlignment = .center
        }
    }
    
}


