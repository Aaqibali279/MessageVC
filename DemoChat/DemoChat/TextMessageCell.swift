//
//  TextMessageCell.swift
//  ADChat
//
//  Created by Aquib on 14/08/19.
//  Copyright © 2019 Aquib. All rights reserved.
//

import UIKit

class TextMessageCell: UITableViewCell {
    private var iv = UIImageView()
    private var bubbleIV = UIImageView()
    private var label = UILabel()
    private var timeLabel = UILabel()
    
    private var labelWidthAnchor:NSLayoutConstraint?
    private var ivTrailing:NSLayoutConstraint?
    private var labelTrailing:NSLayoutConstraint?
    private var bubbleTrailing:NSLayoutConstraint?
    private var bubbleLeading:NSLayoutConstraint?
    private var timeLeading:NSLayoutConstraint?
    private var timeTrailing:NSLayoutConstraint?
    private var ivLeading:NSLayoutConstraint?
    private var labelLeading:NSLayoutConstraint?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let transfrom = layer.transform
        layer.transform = CATransform3DRotate(transfrom, .pi, 1, 0, 0)
        
        selectionStyle = .none
        [label,timeLabel].forEach { (label) in
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            
            label.sizeToFit()
        }
        label.font = UIFont.systemFont(ofSize: 14)
        timeLabel.font = UIFont.systemFont(ofSize: 10)
        timeLabel.textColor = .gray
        timeLabel.text = "10:00 pm"
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        [iv,bubbleIV,label,timeLabel].forEach { (v) in
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        iv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 0).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 0).isActive = true
        
        label.bottomAnchor.constraint(equalTo: iv.bottomAnchor,constant: -4).isActive = true
        
        bubbleIV.topAnchor.constraint(equalTo: label.topAnchor,constant: -4).isActive = true
        bubbleIV.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 8).isActive = true
        
        bubbleTrailing = bubbleIV.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16)
        bubbleTrailing?.isActive = true
        bubbleLeading = bubbleIV.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8)
        bubbleLeading?.isActive = true
        
        
        timeLabel.topAnchor.constraint(equalTo: bubbleIV.bottomAnchor).isActive = true
        
        
        //OUTGOING
        ivTrailing = iv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        labelTrailing = label.trailingAnchor.constraint(equalTo: iv.leadingAnchor, constant: -16)
        timeTrailing = timeLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor)
        
        
        //INCOMMING
        ivLeading = iv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        labelLeading = label.leadingAnchor.constraint(equalTo: iv.trailingAnchor, constant: 16)
        timeLeading = timeLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var message:Message?{
        didSet{
//            timeLabel.text = message?.time?.date(inputFormatter: .input1)?.string(outputFormatter: .output2)
            timeLabel.text = "4:37 AM"
            label.text = message?.text
            setUpDesign(message: message)

        }
    }
    
    private func setUpDesign(message:Message?){
        
        
        if let anchor = labelWidthAnchor {
            label.removeConstraint(anchor)
        }
        
        let width = UIScreen.main.bounds.width - 100
        if let textHeight = message?.text?.height(font: UIFont.systemFont(ofSize: 14), width: width),let textWidth = message?.text?.width(font: UIFont.systemFont(ofSize: 14), height: textHeight){
            if textWidth >= width{
                labelWidthAnchor = label.widthAnchor.constraint(equalToConstant: width)
                labelWidthAnchor?.isActive = true
            }
        }
        
        if message?.fromUsers_id == "1" {
            bubbleIV.image = #imageLiteral(resourceName: "bubble_outgoing").stretchableImage(withLeftCapWidth: 20, topCapHeight: 14)
            ivTrailing?.isActive = true
            labelTrailing?.isActive = true
            ivLeading?.isActive = false
            labelLeading?.isActive = false
            bubbleTrailing?.constant = 16
            bubbleLeading?.constant = -8
            timeTrailing?.isActive = true
            timeLeading?.isActive = false
        
        }else{
            bubbleIV.image = #imageLiteral(resourceName: "bubble_incoming").stretchableImage(withLeftCapWidth: 20, topCapHeight: 14)
            ivLeading?.isActive = true
            labelLeading?.isActive = true
            ivTrailing?.isActive = false
            labelTrailing?.isActive = false
            bubbleTrailing?.constant = 8
            bubbleLeading?.constant = -16
            timeLeading?.isActive = true
            timeTrailing?.isActive = false
        }
        layoutIfNeeded()
        iv.layoutIfNeeded()
//        iv.round()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
   
}
