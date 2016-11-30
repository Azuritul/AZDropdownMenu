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
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = UIColor(red: 80/255, green: 70/255, blue: 66/255, alpha: 1.0)
        title = "AZDropdownMenu"

        /// Add DemoButton 1
        let demoButton1 = buildButton("Demo 1")
        demoButton1.addTarget(self, action: #selector(ViewController.onDemo1Tapped), for: .touchUpInside)
        view.addSubview(demoButton1)

        view.addConstraint(NSLayoutConstraint(item: demoButton1, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: demoButton1, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -180))

        ///  Add DemoButton 2
        let demoButton2 = buildButton("Demo 2")
        demoButton2.addTarget(self, action: #selector(ViewController.onDemo2Tapped), for: .touchUpInside)
        view.addSubview(demoButton2)

        view.addConstraint(NSLayoutConstraint(item: demoButton2, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: demoButton2, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -80))
    }

    func buildButton(_ title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 70/255, blue: 66/255, alpha: 1.0)
        button.setTitle(title, for: UIControlState())
        button.layer.cornerRadius = 4.0
        button.setTitleColor(UIColor(red: 233/255, green: 205/255, blue: 193/255, alpha: 1.0), for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    func onDemo1Tapped() {
        let controller = DemoViewController1()
        let nv = UINavigationController(rootViewController: controller)
        nv.navigationBar.isTranslucent = false
        nv.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        self.present(nv, animated: true, completion: nil)
    }

    func onDemo2Tapped() {
        let controller = DemoViewController2()
        let nv = UINavigationController(rootViewController: controller)
        nv.navigationBar.isTranslucent = false
        nv.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        self.present(nv, animated: true, completion: nil)
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

        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(UIViewController.dismissFromController))
        let rightButton = UIBarButtonItem(image: UIImage(named: "options"), style: .plain, target: self, action: #selector(DemoViewController1.showRightDropdown))

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = rightButton

        title = "Demo 1"
        rightMenu = buildDummyDefaultMenu()
    }

    func showRightDropdown() {
        if self.rightMenu?.isDescendant(of: self.view) == true {
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
        view.backgroundColor = UIColor.white

        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(UIViewController.dismissFromController))
        let menuButton = UIBarButtonItem(image: UIImage(named: "options"), style: .plain, target: self, action: #selector(DemoViewController1.showRightDropdown))
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = menuButton

        rightMenu = buildDummyCustomMenu()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }

    func showRightDropdown() {
        if self.rightMenu?.isDescendant(of: self.view) == true {
            self.rightMenu?.hideMenu()
        } else {
            self.rightMenu?.showMenuFromView(self.view)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {

            cell.textLabel?.text = "TestCell \(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = UIViewController()
        nextVC.view.backgroundColor = UIColor.white
        nextVC.title = "VC \(indexPath.row)"
        self.navigationController?.show(nextVC, sender: self)
    }
}

// MARK: - Extension for holding custom methods
extension UIViewController {

    /**
     Create dummy menu with default settings

     - returns: The dummy menu
     */
    fileprivate func buildDummyDefaultMenu() -> AZDropdownMenu {
        let leftTitles = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        let menu = AZDropdownMenu(titles: leftTitles)
        menu.itemFontSize = 16.0
        menu.itemFontName = "Helvetica"
        menu.cellTapHandler = { [weak self] (indexPath: IndexPath) -> Void in
            self?.pushNewViewController(leftTitles[indexPath.row])
        }

        return menu
    }

    /**
     Create dummy menu with some custom configuration

     - returns: The dummy menu
     */
    fileprivate func buildDummyCustomMenu() -> AZDropdownMenu {
        let dataSource = createDummyDatasource()
        let menu = AZDropdownMenu(dataSource: dataSource )
        menu.cellTapHandler = { [weak self] (indexPath: IndexPath) -> Void in
            self?.pushNewViewController(dataSource[indexPath.row])
        }
        menu.itemHeight = 70
        menu.itemFontSize = 14.0
        menu.itemFontName = "Menlo-Bold"
        menu.itemColor = UIColor.white
        menu.itemFontColor = UIColor(red: 55/255, green: 11/255, blue: 17/255, alpha: 1.0)
        menu.overlayColor = UIColor.black
        menu.overlayAlpha = 0.3
        menu.itemAlignment = .center
        menu.itemImagePosition = .postfix
        menu.menuSeparatorStyle = .none
        menu.shouldDismissMenuOnDrag = true
        return menu
    }

    fileprivate func pushNewViewController(_ title: String) {
        let newController = UIViewController()
        newController.title = title
        newController.view.backgroundColor = UIColor.white
        DispatchQueue.main.async(execute: {
            self.show(newController, sender: self)
        })
    }

    fileprivate func pushNewViewController(_ item: AZDropdownMenuItemData) {
        self.pushNewViewController(item.title)
    }

    fileprivate func createDummyDatasource() -> [AZDropdownMenuItemData] {
        var dataSource: [AZDropdownMenuItemData] = []
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 1", icon:UIImage(imageLiteralResourceName: "1_a")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 2", icon:UIImage(imageLiteralResourceName: "2_a")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 3", icon:UIImage(imageLiteralResourceName: "3_a")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 4", icon:UIImage(imageLiteralResourceName: "4_a")))
        dataSource.append(AZDropdownMenuItemData(title:"Action With Icon 5", icon:UIImage(imageLiteralResourceName: "5_a")))
        return dataSource
    }

    func dismissFromController() {
        self.dismiss(animated: true, completion: nil)
    }
}
