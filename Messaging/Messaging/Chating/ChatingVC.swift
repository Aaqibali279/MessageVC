//
//  ChatingVCViewController.swift
//  ADChat
//
//  Created by Aquib on 14/08/19.
//  Copyright © 2019 Aquib. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class ChatingVC:UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: GrowingTextView!
    
   
    var messages = Array<Message>()
    var isIncoming = false
    var tapGesture = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TextMessageCell.self, forCellReuseIdentifier: "TextMessageCell")
        
        tableView.transform = CGAffineTransform(rotationAngle: (-.pi))
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(tapGestureAction))
        tableView.addGestureRecognizer(tapGesture)
        
        view.layoutSubviews()
        view.layoutIfNeeded()
        if let v = messageTextView.superview{
            v.layer.borderWidth = 1
            v.layer.borderColor = UIColor.black.cgColor
            let height = v.frame.height
            v.layer.cornerRadius = height/2
            v.clipsToBounds = true
        }
        messageTextView.centerVertically()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = false
//        set(title: "Chat")
//        setBackButton()
        navigationItem.title = "Chat"
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enableAutoToolbar = true
       
    }
    
    @objc func refresh(){
        
    }
    
    @objc func tapGestureAction() {
         messageTextView.resignFirstResponder()
    }
      
    @IBAction func sendAction(_ sender: UIButton) {
        
        guard let text = messageTextView.text,!text.isEmpty else {
            return
        }
        messages.insert((Message(fromUsers_id: isIncoming ? "4": "1" , id: "2", message: text, text: messageTextView.text, time: "4:37 AM", toUsers_id: "4")), at: 0)
        messageTextView.text = nil
        isIncoming = !isIncoming
        messageTextView.centerVertically()
        tableView.reloadData()
        tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
    }
    
  
    
    private func setUpTableView(messages:Array<Message>){
        let isAnyNewMessage = messages.count > self.messages.count
        if isAnyNewMessage{
            let count = self.messages.count
            let number = messages.count - count
        
            self.messages = messages.reversed()
            
            var paths = [IndexPath]()
            for i in 0...number - 1{
                paths.append(.init(row: i, section: 0))
            }
            tableView.beginUpdates()
            tableView.insertRows(at: paths, with: .automatic)
            tableView.endUpdates()

        }else if messages.count == 0{
            self.messages.removeAll()
            tableView.reloadData()
        }
        
        
        
    }
    
    

}
extension ChatingVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "TextMessageCell", for: indexPath) as! TextMessageCell
            cell.message = messages[indexPath.row]
        
            return cell
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }

}





