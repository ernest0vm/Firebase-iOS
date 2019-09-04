//
//  ViewController.swift
//  KeyboardShortcuts
//
//  Created by Ernesto Valdez on 9/3/19.
//  Copyright © 2019 Ernesto Valdez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblAllKeys: UILabel!
    @IBOutlet weak var txtShortcutName: UITextField!
    @IBOutlet weak var txtKeys: UITextField!
    let shortcut = Shortcut()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onBtnAddKeyClick(_ sender: UIButton, forEvent event: UIEvent) {
        
        let key: String = txtKeys.text ?? ""
        
        shortcut.Keys.insert(key)
        lblAllKeys.text = lblAllKeys.text! + txtKeys.text! + " "
        txtKeys.text = ""
        
    }
    
    @IBAction func onBtnSaveShortcutClicked(_ sender: UIButton, forEvent event: UIEvent) {
        
        let name:String = txtShortcutName.text!
        shortcut.ShortcutName = name
        
        txtShortcutName.text = ""
        lblAllKeys.text = ""
        shortcut.Keys = []
    }
    
    
    
}

