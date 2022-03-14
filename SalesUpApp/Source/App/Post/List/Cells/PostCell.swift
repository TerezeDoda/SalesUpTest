//
//  PostCell.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUp(post: Post){
       titleLabel.text = post.title
       subTitleLabel.text = post.body
    }
}
