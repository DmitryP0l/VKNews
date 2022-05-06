//
//  NewsFeedCell.swift
//  VKNews
//
//  Created by lion on 6.05.22.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String { get }
    var shares: String { get }
    var views: String { get }
    var photoAttachement: FeedCellPhotoAttachementViewModel? { get }
}

protocol FeedCellPhotoAttachementViewModel {
    var photoUrlString: String { get }
    var width: Int { get }
    var height: Int { get }
}

final class NewsFeedCell: UITableViewCell {
    
    static let identifier = "NewsFeedCell"
    
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.setImage(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likeLabel.text = viewModel.likes
        commentLabel.text = viewModel.comments
        shareLabel.text = viewModel.shares
        viewLabel.text = viewModel.views
        if let photoAttachement = viewModel.photoAttachement {
            postImageView.setImage(imageURL: photoAttachement.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
}
