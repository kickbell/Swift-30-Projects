//
//  sadf.swift
//  Chatlist
//
//  Created by jc.kim on 11/10/21.
//

import UIKit

class KakaoChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var senderImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var lastSentDateLabel: UILabel!
    
    func configure(message: Message) {
        senderImageView.image = message.senderImage
        nameLabel.text = message.senderName
        lastMessageLabel.text = message.lastMessage
        lastSentDateLabel.text = message.lastSentDate
    }
}
