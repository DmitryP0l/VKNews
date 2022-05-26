//
//  NewsFeedCodeCell.swift
//  VKNews
//
//  Created by lion on 8.05.22.
//

import Foundation
import UIKit

protocol NewsFeedCodeCellDelegate: AnyObject {
    func revealPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    static let identifier = "NewsFeedCodeCell"
    weak var delegate: NewsFeedCodeCellDelegate?
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
  //MARK: - top view layer
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: WebImageView = {
       let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.topViewHeight / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
   //MARK: - post label text layer
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    //MARK: - more text button
    
    private let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью", for: .normal)
        return button
    }()
    
    //MARK: - gallery Collection View
    
    private let galleryCollectionView = GalleryCollectionView()
    
   //MARK: - post image view layer
    
    private let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return imageView
    }()
    
    //MARK: - bottom view layer
    
    private let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let likesImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "heart")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "bubble.left")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrowshape.turn.up.right")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "eye")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    private let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.setImage(imageURL: "")
        postImageView.setImage(imageURL: "")
    }
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupView()
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerOnTopView()
        overlayThirdLayerOnBottomView()
        overlayFourthLayersOnBottomViewViews()
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - methods
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.setImage(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
    
        if let photoAttachement = viewModel.photoAttachements.first, viewModel.photoAttachements.count == 1 {
            postImageView.setImage(imageURL: photoAttachement.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachementFrame
        } else if viewModel.photoAttachements.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachementFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachements)
        }
        else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
        
    }
    
    @objc func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    
    private func setupView() {
        contentView.addSubview(cardView)
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(bottomView)
        
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        
    }
    
    private func overlayFirstLayer() {
        cardView.fillSuperview(padding: Constants.cardInserts)
    }
    
    private func overlaySecondLayer() {
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8.0).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8.0).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8.0).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    }
    
    private func overlayThirdLayerOnTopView() {
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight/2 - 2).isActive = true
        
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
   
    // через extension constrains
    private func overlayThirdLayerOnBottomView() {
        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        commentsView.anchor(top: bottomView.topAnchor,
                            leading: likesView.trailingAnchor,
                            bottom: nil,
                            trailing: nil,
                            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        sharesView.anchor(top: bottomView.topAnchor,
                          leading: commentsView.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        viewsView.anchor(top: bottomView.topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: bottomView.trailingAnchor,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
    }
    
    private func overlayFourthLayersOnBottomViewViews() {
        helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        helpInFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        helpInFourthLayer(view: viewsView, imageView: viewsImage, label: viewsLabel)
        
    }
    
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
}
