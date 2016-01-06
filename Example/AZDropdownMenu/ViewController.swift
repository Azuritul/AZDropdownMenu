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
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        let rightButton = UIBarButtonItem(title: "custom", style: UIBarButtonItemStyle.Done, target: self, action: "showRightDropdown")
        let leftButton = UIBarButtonItem(title: "default", style: UIBarButtonItemStyle.Done, target: self, action: "showLeftDropdown")
        
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftButton
        
        self.title = "Demo"
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        
        //Set up left menu
        let leftTitles = ["Default 1", "Default 2", "Default 3", "Default 4", "Hello world", "Test"]
        let tempLeftMenu = AZDropdownMenu(titles: leftTitles )
        tempLeftMenu.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
            self?.pushNewViewController(leftTitles[indexPath.row])
        }
        self.leftMenu = tempLeftMenu
        
        //Set up right menu
        let rightTitles = ["Custom 1", "Custom 2", "Custom 3", "Custom 4", "Hello world"]
        let tempRightMenu = AZDropdownMenu(titles: rightTitles )
        tempRightMenu.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
            self?.pushNewViewController(rightTitles[indexPath.row])
        }
        tempRightMenu.itemHeight = 70
        tempRightMenu.itemFontSize = 18.0
        tempRightMenu.itemColor = UIColor.redColor()
        tempRightMenu.itemFontColor = UIColor.whiteColor()
        tempRightMenu.overlayColor = UIColor.greenColor()
        tempRightMenu.overlayAlpha = 0.3
        tempRightMenu.menuSeparatorStyle = .None
        tempRightMenu.itemAlignment = .Center
        self.rightMenu = tempRightMenu
        
    }
    
    private func pushNewViewController(title: String) {
        let newController = UIViewController()
        newController.title = title
        newController.view.backgroundColor = UIColor.whiteColor()
        dispatch_async(dispatch_get_main_queue(),{
            self.navigationController?.pushViewController(newController, animated: true)
        })
        
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

