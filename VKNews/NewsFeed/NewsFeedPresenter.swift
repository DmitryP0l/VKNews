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
      case .presentUserInfo(user: let user):
          let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
          viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
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
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile?.photo ?? "noPhoto",
                                       name: profile?.name ?? "noName",
                                       date: dateTitle,
                                       text: postText,
                                       likes: formattedCounter(feedItem.likes?.count),
                                       comments: formattedCounter(feedItem.comments?.count) ?? "",
                                       shares: formattedCounter(feedItem.reposts?.count) ?? "",
                                       views: formattedCounter(feedItem.views?.count) ?? "",
                                       photoAttachements: photoAttachments,
                                       sizes: sizes)
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        if 4...6 ~= counterString.count{
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(3)) + "M"
        }
        return counterString
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
