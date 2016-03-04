//
//  ViewController.swift
//  AZDropdownMenu
//
//  Created by Chris Wu on 01/05/2016.
//  Copyright (c) 2016 Chris Wu. All rights reserved.
//

import UIKit
import AZDropdownMenu

class ViewController: UIViewController {

    var rightMenu: AZDropdownMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false
        navigationController?.navigationBar.translucent = false
        view.backgroundColor = UIColor(red: 80/255, green: 70/255, blue: 66/255, alpha: 1.0)
        title = "AZDropdownMenu"

        /// Add DemoButton 1
        let demoButton1 = buildButton("Demo 1")
        demoButton1.addTarget(self, action: "onDemo1Tapped", forControlEvents: .TouchUpInside)
        view.addSubview(demoButton1)

        view.addConstraint(NSLayoutConstraint(item: demoButton1, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: demoButton1, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: -180))

        ///  Add DemoButton 2
        let demoButton2 = buildButton("Demo 2")
        demoButton2.addTarget(self, action: "onDemo2Tapped", forControlEvents: .TouchUpInside)
        view.addSubview(demoButton2)

        view.addConstraint(NSLayoutConstraint(item: demoButton2, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: demoButton2, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: -80))
    }

    func buildButton(title: String) -> UIButton {
        let button = UIButton(type: .System)
        button.backgroundColor = UIColor(red: 80/255, green: 70/255, blue: 66/255, alpha: 1.0)
        button.setTitle(title, forState: .Normal)
        button.layer.cornerRadius = 4.0
        button.setTitleColor(UIColor(red: 233/255, green: 205/255, blue: 193/255, alpha: 1.0), forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    func onDemo1Tapped() {
        let controller = DemoViewController1()
        let nv = UINavigationController(rootViewController: controller)
        nv.navigationBar.translucent = false
        nv.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        self.presentViewController(nv, animated: true, completion: nil)
    }

    func onDemo2Tapped() {
        let controller = DemoViewController2()
        let nv = UINavigationController(rootViewController: controller)
        nv.navigationBar.translucent = false
        nv.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        self.presentViewController(nv, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

/// Example controller that shows the use of menu with UIViewController
class DemoViewController1: UIViewController {

    var rightMenu: AZDropdownMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 80/255, green: 70/255, blue: 66/255, alpha: 1.0)

        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel"), style: .Plain, target: self, action: "dismiss")
        let rightButton = UIBarButtonItem(image: UIImage(named: "options"), style: .Plain, target: self, action: "showRightDropdown")

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = rightButton

        title = "Demo 1"
        rightMenu = buildDummyDefaultMenu()
    }

    func showRightDropdown() {
        if self.rightMenu?.isDescendantOfView(self.view) == true {
            self.rightMenu?.hideMenu()
        } else {
            self.rightMenu?.showMenuFromView(self.view)
        }
    }
}

/// Example that shows the use of menu with UITableViewController
class DemoViewController2: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var rightMenu: AZDropdownMenu?
    var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Demo 2"
        view.backgroundColor = UIColor.whiteColor()

        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel"), style: .Plain, target: self, action: "dismiss")
        let menuButton = UIBarButtonItem(image: UIImage(named: "options"), style: .Plain, target: self, action: "showRightDropdown")
        tableView.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen().bounds), CGRectGetHeight(UIScreen.mainScreen().bounds))
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = menuButton

        rightMenu = buildDummyCustomMenu()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }

    func showRightDropdown() {
        if self.rightMenu?.isDescendantOfView(self.view) == true {
            self.rightMenu?.hideMenu()
        } else {
            self.rightMenu?.showMenuFromView(self.view)
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("cell") {

            cell.textLabel?.text = "TestCell \(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let nextVC = UIViewController()
        nextVC.view.backgroundColor = UIColor.whiteColor()
        nextVC.title = "VC \(indexPath.row)"
        self.navigationController?.showViewController(nextVC, sender: self)
    }
}

// MARK: - Extension for holding custom methods
extension UIViewController {

    /**
     Create dummy menu with default settings

     - returns: The dummy menu
     */
    private func buildDummyDefaultMenu() -> AZDropdownMenu {
        let leftTitles = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        let menu = AZDropdownMenu(titles: leftTitles)
        menu.itemFontSize = 16.0
        menu.itemFontName = "Helvetica"
        menu.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
            self?.pushNewViewController(leftTitles[indexPath.row])
        }

        return menu
    }

    /**
     Create dummy menu with some custom configuration

     - returns: The dummy menu
     */
    private func buildDummyCustomMenu() -> AZDropdownMenu {
        let dataSource = createDummyDatasource()
        let menu = AZDropdownMenu(dataSource: dataSource )
        menu.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
            self?.pushNewViewController(dataSource[indexPath.row])
        }
        menu.itemHeight = 70
        menu.itemFontSize = 14.0
        menu.itemFontName = "Menlo-Bold"
        menu.itemColor = UIColor.whiteColor()
        menu.itemFontColor = UIColor(red: 55/255, green: 11/255, blue: 17/255, alpha: 1.0)
        menu.overlayColor = UIColor.blackColor()
        menu.overlayAlpha = 0.3
        menu.itemAlignment = .Center
        menu.itemImagePosition = .Postfix
        menu.menuSeparatorStyle = .None
        menu.shouldDismissMenuOnDrag = true
        return menu
    }

    private func pushNewViewController(title: String) {
        let newController = UIViewController()
        newController.title = title
        newController.view.backgroundColor = UIColor.whiteColor()
        dispatch_async(dispatch_get_main_queue(), {
            self.showViewController(newController, sender: self)
        })
    }

    private func pushNewViewController(item: AZDropdownMenuItemData) {
        self.pushNewViewController(item.title)
    }

    private func createDummyDatasource() -> [AZDropdownMenuItemData] {
        var dataSource: [AZDropdownMenuItemData] = []
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 1", icon:UIImage(imageLiteral: "1_a")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 2", icon:UIImage(imageLiteral: "2_a")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 3", icon:UIImage(imageLiteral: "3_a")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 4", icon:UIImage(imageLiteral: "4_a")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 5", icon:UIImage(imageLiteral: "5_a")))
        return dataSource
    }

    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}