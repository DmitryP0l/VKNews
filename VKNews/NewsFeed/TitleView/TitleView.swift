//
//  TitleView.swift
//  VKNews
//
//  Created by lion on 26.05.22.
//

import Foundation
import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

class TitleView: UIView {
    
    private var myTextField = InsetableTextField()
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        settingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set( userViewModel: TitleViewViewModel) {
        myAvatarView.setImage(imageURL: userViewModel.photoUrlString!)
    }
    
    private func settingView() {
        addSubview(myAvatarView)
        addSubview(myTextField)
        
        myAvatarView.anchor(top: topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 4))
        myAvatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        
        myTextField.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: myAvatarView.leadingAnchor,
                           padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
    }
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
}
