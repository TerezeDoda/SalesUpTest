//
//  NoDataView.swift
//  SalesUpApp
//
//  Created by ritech on 14.3.22.
//

import UIKit

enum NoDataType {
    case posts
}

class NoDataView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    class func instanceFromNib(noDataType: NoDataType) -> NoDataView {
        let noDataView = UINib(nibName: "NoDataView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NoDataView
        switch noDataType {
        case .posts:
            let noMessages = NoDataViews().posts
            noDataView.imageView.image = UIImage(systemName: "ipc_info_port")
            noDataView.titleLabel.text = noMessages.title
            noDataView.subtitleLabel.text = noMessages.subtitle
        }
        return noDataView
    }
}

struct NoDataViews {
    let posts = NoDataModel(title: "No Posts", subtitle: "At the moment there are no posts")
}

class NoDataModel {
    var title: String = ""
    var subtitle: String = ""

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
