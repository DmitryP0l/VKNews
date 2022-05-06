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
      tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      setup()
  }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {
      switch viewModel {
      case .some:
          print(".some.viewComtroller")
      case .displayNewsFeed:
          print(".displayNewsFeed ViewController")
          print("готовыми данными, которые пришли от Presenter, можно заполнять ячейки, поля и т.д")
      }
  }
  
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = "index \(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select cell \(indexPath.row) у ViewController")
        print("срабатывает метод makeRequest у interactor с целью получить данные и переходим в файл Interactor")
        interactor?.makeRequest(request: .getFeed)
        
    }
    
    
}
