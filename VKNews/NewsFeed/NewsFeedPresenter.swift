//
//  NewsFeedPresenter.swift
//  VKNews
//
//  Created by lion on 5.05.22.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

final class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    var cellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
      switch response {
      case .presentNewsFeed(let feed, let revealedPostsIds):
          
          let cells = feed.items.map { (feedItem) in
              cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostsIds: revealedPostsIds)
          }
          let feedViewModel = FeedViewModel.init(cells: cells)
          viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
      }
  }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostsIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        let isFullSized = revealedPostsIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text,
                                               photoAttachments: photoAttachments,
                                               isFullSizedPost: isFullSized)
        
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile?.photo ?? "noPhoto",
                                       name: profile?.name ?? "noName",
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachements: photoAttachments,
                                       sizes: sizes)
    }
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenable? {
        let profilesOrGroups: [ProfileRepresenable] = sourceId > 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        return profileRepresentable
    }
    private func photoAttachement(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachement? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: firstPhoto.srcBIG,
                                                           width: firstPhoto.width,
                                                           height: firstPhoto.height)
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachement] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap ({ (attachment) -> FeedViewModel.FeedCellPhotoAttachement? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: photo.srcBIG,
                                                               width: photo.width,
                                                               height: photo.height)
        })
    }
}
