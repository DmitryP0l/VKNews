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
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
      switch response {
      case .some:
          print(".some.presenter")
      case .presentNewsFeed:
          print(".presentNewsFeed Presenter")
          print("полученные данные от Interactor, подготавливаем для отображения, сворачиваем в модель и передадим в displayData у viewController и возвращаяемся в файл ViewController")
          viewController?.displayData(viewModel: .displayNewsFeed)
      }
  }
  
}
