//
//  NewsFeedModels.swift
//  VKNews
//
//  Created by lion on 5.05.22.
//

import UIKit

enum NewsFeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case revealPostID(postID: Int)
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse, revealedPostsIds: [Int])
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeedViewModel)
            }
        }
    }
}


struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int
        var iconUrlString: String        
        var name: String        
        var date: String        
        var text: String?        
        var likes: String?        
        var comments: String
        var shares: String
        var views: String
        var photoAttachements: [FeedCellPhotoAttachementViewModel]
         var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachement: FeedCellPhotoAttachementViewModel {
        var photoUrlString: String
        var width: Int
        var height: Int
    }
    let cells: [Cell]
}
