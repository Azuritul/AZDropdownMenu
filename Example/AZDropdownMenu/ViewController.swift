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
    var leftMenu: AZDropdownMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        self.view.backgroundColor = UIColor(red: 242/255, green: 229/255, blue: 213/255, alpha: 1.0)
        
        let leftButton = UIBarButtonItem(title: "default", style: UIBarButtonItemStyle.Done, target: self, action: "showLeftDropdown")
        let rightButton = UIBarButtonItem(title: "custom", style: UIBarButtonItemStyle.Done, target: self, action: "showRightDropdown")
        
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
        
        self.title = "Demo"
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        
        self.leftMenu = buildDummyDefaultMenu()
        self.rightMenu = buildDummyCustomMenu()
    }
    
    /**
     Create dummy menu with default settings
     
     - returns: The dummy menu
     */
    private func buildDummyDefaultMenu() -> AZDropdownMenu {
        let leftTitles = ["Default 1", "Default 2", "Default 3", "Default 4", "Hello world", "Test"]
        let menu = AZDropdownMenu(titles: leftTitles)
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
        menu.itemFontSize = 16.0
        menu.itemFontName = "Menlo-Bold"
        menu.itemColor = UIColor(red: 243/255, green: 241/255, blue: 241/255, alpha: 1.0)
        menu.itemFontColor = UIColor(red: 55/255, green: 11/255, blue: 17/255, alpha: 1.0)
        menu.overlayColor = UIColor.whiteColor()
        menu.overlayAlpha = 0.3
        menu.itemAlignment = .Center
        return menu
    }
    
    private func pushNewViewController(title: String) {
        let newController = UIViewController()
        newController.title = title
        newController.view.backgroundColor = UIColor.whiteColor()
        dispatch_async(dispatch_get_main_queue(),{
            self.navigationController?.pushViewController(newController, animated: true)
        })
    }
    
    private func pushNewViewController(item:AZDropdownMenuItemData) {
        self.pushNewViewController(item.title)
    }
    
    private func createDummyDatasource() -> [AZDropdownMenuItemData] {
        var dataSource : [AZDropdownMenuItemData] = []
        for index in  0..<5 {
            switch(index){
            case 0:
                let i = AZDropdownMenuItemData(title:"Action With Icon 1", icon:UIImage(imageLiteral: "glyphicons-1-glass"))
                dataSource.append(i)
            case 1:
                let i = AZDropdownMenuItemData(title:"Action With Icon 2", icon:UIImage(imageLiteral: "glyphicons-2-leaf"))
                dataSource.append(i)
            case 2:
                let i = AZDropdownMenuItemData(title:"Action With Icon 3", icon:UIImage(imageLiteral: "glyphicons-14-beach-umbrella"))
                dataSource.append(i)
            case 3:
                let i = AZDropdownMenuItemData(title:"Action With Icon 4", icon:UIImage(imageLiteral: "glyphicons-16-print"))
                dataSource.append(i)
            case 4:
                let i = AZDropdownMenuItemData(title:"Action With Icon 5", icon:UIImage(imageLiteral: "glyphicons-28-search"))
                dataSource.append(i)
            default:break
            }
        }
        return dataSource
    }
    
    func showRightDropdown(){
        if(self.rightMenu?.isDescendantOfView(self.view) == true) {
            self.rightMenu?.hideMenu()
        } else {
            self.rightMenu?.showMenuFromView(self.view)
        }
    }
    
    func showLeftDropdown(){
        if(self.leftMenu?.isDescendantOfView(self.view) == true) {
            self.leftMenu?.hideMenu()
        } else {
            self.leftMenu?.showMenuFromView(self.view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

