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
      case .some:
          print(".some interactor")
      case .getFeed:
          print(".getFeed Interactor")
          print("в данном файле делаем сетевой запрос, и полученные данные будем передавать в presentData у presenter и переходим в Presenter")
          presenter?.presentData(response: .presentNewsFeed)
      }
  }
  
}
