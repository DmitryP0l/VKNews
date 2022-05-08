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
      case .presentNewsFeed(feed: let feed):
          let cells = feed.items.map { (feedItem) in
              cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
          }
          let feedViewModel = FeedViewModel.init(cells: cells)
          viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
      }
  }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachement = self.photoAttachement(feedItem: feedItem)
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachement: photoAttachement)
        
        return FeedViewModel.Cell.init(iconUrlString: profile?.photo ?? "noPhoto",
                                       name: profile?.name ?? "noName",
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachement: photoAttachement,
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
        guard let photos = feedItem.attachments?.compactMap({ (attachement) in
            attachement.photo
        }), let firstPhoto = photos.first else {
            return nil
        }
        return FeedViewModel.FeedCellPhotoAttachement.init(photoUrlString: firstPhoto.srcBIG,
                                                           width: firstPhoto.width,
                                                           height: firstPhoto.height)
    }
}
