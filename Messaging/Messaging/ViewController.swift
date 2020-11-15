//
//  ViewController.swift
//  Messaging
//
//  Created by Aqib Ali on 15/11/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnChatAction(_ sender: Any) {
        if let vc = UIStoryboard(name: "Chat", bundle: .main).instantiateViewController(withIdentifier: "ChatingVC") as? ChatingVC{
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}

