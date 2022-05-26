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
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    private var revealedPostsIds = [Int]()
    private var feedResponse: FeedResponse?
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
      switch request {
      case .getNewsFeed:
          fetcher.getFeed { [weak self](feedResponse) in
              self?.feedResponse = feedResponse
              self?.presentFeed()
          }
      case .revealPostID(postID: let postID):
          revealedPostsIds.append(postID)
          presentFeed()
      case .getUser:
          fetcher.getUser { userResponse in
              self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: userResponse))
          }
      }
  }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse, revealedPostsIds: revealedPostsIds))
    }
  
}
