//
//  NewsFeedInteractor.swift
//  VKNews
//
//  Created by lion on 5.05.22.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}


final class NewsFeedInteractor: NewsFeedBusinessLogic {

    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
      switch request {
          
      case .getNewsFeed:
          service?.getFeed(completion: { [weak self] revealedPostIds, feed in
              self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealedPostsIds: revealedPostIds))
          })
      case .getUser:
          service?.getUser(completion: { [weak self] user in
              self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: user))
          })
      case .revealPostID(postID: let postID):
          service?.revealPostIds(forPostId: postID, completion: { [weak self] revealedPostIds, feed in
              self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealedPostsIds: revealedPostIds))
          })
      case .getNextBatch:
          print("hell")
      }
  }
  
}
