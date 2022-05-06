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
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse)
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
        var iconUrlString: String        
        var name: String        
        var date: String        
        var text: String?        
        var likes: String?        
        var comments: String
        var shares: String
        var views: String
        var photoAttachement: FeedCellPhotoAttachementViewModel?
    }
    
    struct FeedCellPhotoAttachement: FeedCellPhotoAttachementViewModel {
        var photoUrlString: String
        var width: Int
        var height: Int
    }
    let cells: [Cell]
}
