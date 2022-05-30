//
//  NewsFeedWorker.swift
//  VKNews
//
//  Created by lion on 5.05.22.
//

import UIKit

final class NewsFeedService {

    var authService: AuthService
    var networking: Networking
    var fetcher: DataFetcher
    
    private var revealedPostsIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        self.authService = SceneDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fetcher.getUser { userResponse in
            completion(userResponse)
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed { [weak self] feed in
            self?.feedResponse = feed
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealedPostsIds, feedResponse)
        }
    }
    func revealPostIds(forPostId postID: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        revealedPostsIds.append(postID)
        guard let feedResponse = self.feedResponse else { return }
        completion(revealedPostsIds, feedResponse)
    }
    
    func getNextBath(completion: @escaping ([Int], FeedResponse) -> Void ){
        newFromInProcess  = feedResponse?.nextFrom
        fetcher.getFeed { feed in
            <#code#>
        }
    }
}
