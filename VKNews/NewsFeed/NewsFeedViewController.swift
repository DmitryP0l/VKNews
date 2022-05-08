//
//  NewsFeedViewController.swift
//  VKNews
//
//  Created by lion on 5.05.22.
//

import UIKit

protocol NewsFeedDisplayLogic: AnyObject {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}


final class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {

    @IBOutlet weak var tableView: UITableView!
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic)?
    private var feedViewModel = FeedViewModel.init(cells: [])

  
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
      view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
      setup()
      setupTableView()
      interactor?.makeRequest(request: .getNewsFeed)
      
  }
    private func setupTableView() {
        tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
    }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
      switch viewModel {
      case .displayNewsFeed(feedViewModel: let feedViewModel):
          self.feedViewModel = feedViewModel
          tableView.reloadData()
      }
  }
  
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.identifier, for: indexPath) as! NewsFeedCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
}
