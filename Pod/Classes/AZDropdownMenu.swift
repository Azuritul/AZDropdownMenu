//
//  AZDropdownMenu.swift
//  AZDropdownMenu
//
//  Created by Chris Wu on 01/05/2016.
//  Copyright (c) 2016 Chris Wu. All rights reserved.
//

import UIKit

public class AZDropdownMenu: UIView {

    private let DROPDOWN_MENU_CELL_KEY : String = "MenuItemCell"

    /// The dark overlay behind the menu
    private let overlay:UIView = UIView()
    private var menuView: UITableView!

    /// Array of titles for the menu
    private var titles = [String]()

    /// Property to figure out if initial layout has been configured
    private var isSetUpFinished : Bool

    /// The handler used when menu item is tapped
    public var cellTapHandler : ((indexPath:NSIndexPath) -> Void)?

    // MARK: - Configuration options

    /// Row height of the menu item
    public var itemHeight : Int = 44 {
        didSet {
            let menuFrame = CGRectMake(0, 0, frame.size.width, menuHeight)
            self.menuView.frame = menuFrame
        }
    }

    /// The color of the menu item
    public var itemColor : UIColor = UIColor.whiteColor() {
        didSet {
            self.menuConfig?.itemColor = itemColor
        }
    }

    /// The background color of the menu item while being tapped
    public var itemSelectionColor : UIColor = UIColor.lightGrayColor() {
        didSet {
            self.menuConfig?.itemSelectionColor = itemSelectionColor
        }
    }

    /// The font of the item
    public var itemFontName : String = "Helvetica" {
        didSet {
            self.menuConfig?.itemFont = itemFontName
        }
    }

    /// The text color of the menu item
    public var itemFontColor : UIColor = UIColor(red: 140/255, green: 134/255, blue: 125/255, alpha: 1.0) {
        didSet {
            self.menuConfig?.itemFontColor = itemFontColor
        }
    }

    /// Font size of the menu item
    public var itemFontSize : CGFloat = 14.0 {
        didSet {
            self.menuConfig?.itemFontSize = itemFontSize
        }
    }

    /// The alpha for the background overlay
    public var overlayAlpha : CGFloat = 0.5 {
        didSet {
            self.menuConfig?.overlayAlpha = self.overlayAlpha
        }
    }

    /// Color for the background overlay
    public var overlayColor : UIColor = UIColor.blackColor() {
        didSet {
            self.overlay.backgroundColor = self.overlayColor
            self.menuConfig?.overlayColor = self.overlayColor
        }
    }

    public var menuSeparatorStyle:AZDropdownMenuSeperatorStyle = .Singleline {
        didSet {
            switch menuSeparatorStyle {
                case .None:
                    self.menuView.separatorStyle = .None
                    self.menuConfig?.menuSeparatorStyle = .None
                case .Singleline:
                    self.menuView.separatorStyle = .SingleLine
                    self.menuConfig?.menuSeparatorStyle = .Singleline
            }
        }
    }

    public var menuSeparatorColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.menuConfig?.menuSeparatorColor = self.menuSeparatorColor
            self.menuView.separatorColor = self.menuSeparatorColor
        }
    }

    /// The text alignment of the menu item
    public var itemAlignment : AZDropdownMenuItemAlignment = .Left {
        didSet {
            switch itemAlignment {
                case .Right:
                    self.menuConfig?.itemAlignment = .Right
                case .Left:
                    self.menuConfig?.itemAlignment = .Left
                case .Center:
                    self.menuConfig?.itemAlignment = .Center
            }
        }
    }

    /// The image position, default to .Prefix.  Image will be displayed after item's text if set to .Postfix
    public var itemImagePosition : AZDropdownMenuItemImagePosition = .Prefix {
        didSet {
            switch itemImagePosition {
            case .Prefix:
                self.menuConfig?.itemImagePosition = .Prefix
            case .Postfix:
                self.menuConfig?.itemImagePosition = .Postfix
            }
        }
    }

    public var shouldDismissMenuOnDrag : Bool = false

    private var calcMenuHeight : CGFloat {
        get {
            return CGFloat(itemHeight * itemDataSource.count)
        }
    }

    private var menuHeight : CGFloat {
        get {
            return (calcMenuHeight > frame.size.height) ? frame.size.height : calcMenuHeight
        }
    }

    private var initialMenuCenter : CGPoint = CGPointMake(0, 0)
    private var itemDataSource : [AZDropdownMenuItemData] = []
    private var reuseId : String?
    private var menuConfig : AZDropdownMenuConfig?

    // MARK: - Initializer
    public init(titles:[String]) {
        self.isSetUpFinished = false
        self.titles = titles
        for title in titles {
            itemDataSource.append(AZDropdownMenuItemData(title: title))
        }
        self.menuConfig = AZDropdownMenuConfig()
        super.init(frame:UIScreen.mainScreen().bounds)
        self.accessibilityIdentifier = "AZDropdownMenu"
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0.95
        self.translatesAutoresizingMaskIntoConstraints = false
        initOverlay()
        initMenu()
    }

    public init(dataSource:[AZDropdownMenuItemData]) {
        self.isSetUpFinished = false
        self.itemDataSource = dataSource
        self.menuConfig = AZDropdownMenuConfig()
        super.init(frame:UIScreen.mainScreen().bounds)
        self.accessibilityIdentifier = "AZDropdownMenu"
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0.95
        self.translatesAutoresizingMaskIntoConstraints = false
        initOverlay()
        initMenu()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override public func layoutSubviews() {
        if isSetUpFinished == false {
            setupInitialLayout()
        }
    }

    private func initOverlay() {
        let frame = UIScreen.mainScreen().bounds
        overlay.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)
        overlay.backgroundColor = self.overlayColor
        overlay.accessibilityIdentifier = "OVERLAY"
        overlay.alpha = 0
        overlay.userInteractionEnabled = true
        let touch : UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AZDropdownMenu.overlayTapped))
        overlay.addGestureRecognizer(touch)
        let panGesture  = UIPanGestureRecognizer(target: self, action: #selector(AZDropdownMenu.handlePan(_:)))
        panGesture.delegate = self
        overlay.addGestureRecognizer(panGesture)
        addSubview(overlay)
    }

    private func initMenu() {
        let frame = UIScreen.mainScreen().bounds
        let menuFrame = CGRectMake(0, 0, frame.size.width, menuHeight)

        menuView = UITableView(frame: menuFrame, style: .Plain)
        menuView.userInteractionEnabled = true
        menuView.rowHeight = CGFloat(itemHeight)
        if self.reuseId == nil {
            self.reuseId = DROPDOWN_MENU_CELL_KEY
        }
        menuView.dataSource = self
        menuView.delegate = self
        menuView.scrollEnabled = false
        menuView.accessibilityIdentifier = "MENU"
        menuView.separatorColor = menuConfig?.menuSeparatorColor
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(AZDropdownMenu.handlePan(_:)))
        panGesture.delegate = self
        menuView.addGestureRecognizer(panGesture)
        addSubview(menuView)
    }

    private func setupInitialLayout() {

        let height = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: UIScreen.mainScreen().bounds.height)
        let width = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: UIScreen.mainScreen().bounds.width)

        addConstraints([height, width])
        isSetUpFinished = true

    }

    private func animateOvelay(alphaValue: CGFloat, interval: Double, completionHandler: (() -> Void)? ) {
        UIView.animateWithDuration(
            interval,
            animations: {
                self.overlay.alpha = alphaValue
            }, completion: { (finished: Bool) -> Void in
                if let completionHandler = completionHandler {
                    completionHandler()
                }
            }
        )
    }

    func overlayTapped() {
        hideMenu()
    }

    //MARK: - Public methods to control the menu

    /**
    Show menu

    - parameter view: The view to be attached by the menu, ex. the controller's view
    */
    public func showMenuFromView(view:UIView) {

        view.addSubview(self)

        animateOvelay(overlayAlpha, interval: 0.4, completionHandler: nil)
        menuView.reloadData()
        UIView.animateWithDuration(
            0.2,
            delay:0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.6,
            options:[],
            animations: {
                self.frame.origin.y = view.frame.origin.y
                }, completion: { (finished : Bool) -> Void in
                self.initialMenuCenter = self.menuView.center
            }
        )
    }

    public func showMenuFromRect(rect:CGRect) {
        let window = UIApplication.sharedApplication().keyWindow!

        let menuFrame = CGRectMake(0, rect.origin.y, frame.size.width, menuHeight)
        self.menuView.frame = menuFrame

        window.addSubview(self)

        animateOvelay(overlayAlpha, interval: 0.4, completionHandler: nil)
        menuView.reloadData()
        UIView.animateWithDuration(
            0.2,
            delay:0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.6,
            options:[],
            animations: {
                self.frame.origin.y = rect.origin.y
            }, completion: { (finished : Bool) -> Void in
                self.initialMenuCenter = self.menuView.center
            }
        )
    }

    public func hideMenu() {

        animateOvelay(0.0, interval: 0.1, completionHandler: nil)

        UIView.animateWithDuration(
            0.3, delay: 0.1,
            options: [],
            animations: {
                self.frame.origin.y = -1200
            },
            completion: { (finished: Bool) -> Void in
                self.menuView.center = self.initialMenuCenter
                self.removeFromSuperview()
            }
        )
    }
}


// MARK: - UITableViewDataSource
extension AZDropdownMenu: UITableViewDataSource {

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemDataSource.count
    }

    func getCellByData() -> AZDropdownMenuBaseCell? {
        if let _ = itemDataSource.first?.icon {
            return AZDropdownMenuDefaultCell(reuseIdentifier: DROPDOWN_MENU_CELL_KEY, config: self.menuConfig!)
        } else {
            return AZDropdownMenuBaseCell(style: .Default, reuseIdentifier: DROPDOWN_MENU_CELL_KEY)
        }
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = getCellByData() {
            let item = itemDataSource[indexPath.row]
            if let config = self.menuConfig {
                cell.configureStyle(config)
            }
            cell.configureData(item)
            cell.layoutIfNeeded()
            return cell
        }
        return UITableViewCell()
    }

}


// MARK: - UITableViewDelegate
extension AZDropdownMenu: UITableViewDelegate {

    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        cellTapHandler?(indexPath:indexPath)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.backgroundColor = itemSelectionColor
        }

        hideMenu()
    }

    public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.backgroundColor = itemColor
        }
    }

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(itemHeight)
    }

}

// MARK: - UIGestureRecognizerDelegate
extension AZDropdownMenu: UIGestureRecognizerDelegate {

    public func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        guard self.shouldDismissMenuOnDrag == true else {
            return
        }

        if gestureRecognizer.isKindOfClass(UIPanGestureRecognizer.self) {
            if let touchedView = gestureRecognizer.view where touchedView == self.menuView {
                let translationView = gestureRecognizer.translationInView(self)
                switch gestureRecognizer.state {
                    case .Changed:
                        let center = touchedView.center
                        let targetPoint = center.y + translationView.y
                        let newLocation = targetPoint < initialMenuCenter.y ? targetPoint : initialMenuCenter.y
                        touchedView.center = CGPointMake(center.x, newLocation)
                        gestureRecognizer.setTranslation(CGPointMake(0, 0), inView: touchedView)
                    case .Ended:
                        if touchedView.center.y < initialMenuCenter.y {
                            hideMenu()
                        }
                    default:break
                }
            }
        }
    }
}


/**
 *  Menu's model object
 */
public struct AZDropdownMenuItemData {

    public let title:String
    public let icon:UIImage?

    public init(title:String) {
        self.title = title
        self.icon = nil
    }

    public init(title:String, icon:UIImage) {
        self.title = title
        self.icon = icon
    }
}
