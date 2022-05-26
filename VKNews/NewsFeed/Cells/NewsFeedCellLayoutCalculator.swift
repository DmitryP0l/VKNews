//
//  NewsFeedCellLayoutCalculator.swift
//  VKNews
//
//  Created by lion on 7.05.22.
//

import UIKit

protocol NewsFeedCellLayoutCalculatorProtocol {
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachementViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachementFrame: CGRect
}

final class NewsFeedCellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width,UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachementViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
        var showMoreTextButton = false
        
// MARK: - postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left,
                                                    y: Constants.postLabelInserts.top),
                                    size: CGSize.zero)
        if let postText = postText, !postText.isEmpty {
            let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
            var height = postText.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifieldPostLines
                showMoreTextButton = true
            }
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
// MARK: - moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInserts.left, y: postLabelFrame.maxY + 4)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
// MARK: - attachementFrame
        
        let attachementTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top :
        Constants.postLabelInserts.bottom + moreTextButtonFrame.maxY
        
        var attachementFrame = CGRect(origin: CGPoint(x: 0,
                                                      y: attachementTop),
                                      size: CGSize.zero)
        
        if let photoAttachement = photoAttachments.first {
            let photoHeight = Float(photoAttachement.height)
            let photoWidth = Float(photoAttachement.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            if photoAttachments.count == 1 {
                attachementFrame.size = CGSize(width: cardViewWidth,
                                               height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                let rowHeight = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photosArray: photos)
                attachementFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
            }
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
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachementFrame: attachementFrame)
    }
}
