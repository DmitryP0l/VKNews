//
//  NewsFeedCellLayoutCalculator.swift
//  VKNews
//
//  Created by lion on 7.05.22.
//

import UIKit

protocol NewsFeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachementViewModel?) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    var postLabelFrame: CGRect
    var attachementFrame: CGRect
}

final class NewsFeedCellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width,UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachementViewModel?) -> FeedCellSizes {
        let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
        
// MARK: - postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left,
                                                    y: Constants.postLabelInserts.top),
                                    size: CGSize.zero)
        if let postText = postText, !postText.isEmpty {
            let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
            let height = postText.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
// MARK: - attachementFrame
        
        let attachementTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top :
        Constants.postLabelInserts.bottom + postLabelFrame.maxY
        
        var attachementFrame = CGRect(origin: CGPoint(x: 0,
                                                      y: attachementTop),
                                      size: CGSize.zero)
        if let photoAttachement = photoAttachement {
            let photoHeight = Float(photoAttachement.height)
            let photoWidth = Float(photoAttachement.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            attachementFrame.size = CGSize(width: cardViewWidth,
                                           height: cardViewWidth * ratio)
        }
     
// MARK: - bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY,
                                attachementFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0,
                                                     y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth,
                                                  height: Constants.bottomViewHeight))
 
// MARK: - totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
        
        return Sizes(bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabelFrame,
                     attachementFrame: attachementFrame)
    }
}
