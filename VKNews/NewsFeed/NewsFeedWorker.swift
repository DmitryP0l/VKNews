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
        fetcher.getFeed(nextBathFrom: nil) { [weak self] feed in
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
        fetcher.getFeed(nextBathFrom: newFromInProcess) { [weak self] feed in
            guard let feed = feed else { return }
            guard self?.feedResponse?.nextFrom != feed.nextFrom else { return }
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            } else {
                self?.feedResponse?.items.append(contentsOf: feed.items)

                var profiles = feed.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { oldProfile in
                        !feed.profiles.contains(where: { $0.id == oldProfile.id })
                    }
                    profiles.append(contentsOf: oldProfilesFiltered)
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = feed.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter { oldGroups in
                        !feed.groups.contains(where: { $0.id == oldGroups.id })
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
                self?.feedResponse?.nextFrom = feed.nextFrom
            }
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealedPostsIds, feedResponse)
        }
    }
}
