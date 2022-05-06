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
                case some
                case getFeed
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentNewsFeed
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayNewsFeed
            }
        }
    }
  
}
