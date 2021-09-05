//
//  ViewController.swift
//  365ScoreTest
//
//  Created by Nikita Koniukh on 03/09/2021.
//

import UIKit

class GamesListViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    let apiService = APIService()
    var groupedGamesArray = [[Game]]()
    var groupedEnumArray = [[GameListEnum]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService.fetcChampionship { [self] gamesRes in
            switch gamesRes {
            case .success(let games, let gameEnumArray):
                self.groupedGamesArray = games
                self.groupedEnumArray = gameEnumArray
                print(Constants.errorMessagePrint)
                self.tableView.reloadData()
                break
            case .failure( let errorMessage):
                let alert = UIAlertController(title: "Error", message: errorMessage.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            }
        }
        initView()
    }
    
    func initView() {
        // tableView customization
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        tableView.register(GameTableViewCell.nib, forCellReuseIdentifier: GameTableViewCell.identifier)
        tableView.register(HederGroupTableViewCell.nib, forCellReuseIdentifier: HederGroupTableViewCell.identifier)
        
        // navigation controller
        title = Constants.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
}


extension GamesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedEnumArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedEnumArray[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return formatDate(dateToFormat: groupedGamesArray[section][0].dateTime,
                          inputFormat: "dd-MM-yyyy HH:mm",
                          outputFormat: "dd/MM/yyyy")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let gameListEnum = groupedEnumArray[indexPath.section][indexPath.row]
        
        switch gameListEnum {
        case let .Competition (competition):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HederGroupTableViewCell.identifier, for: indexPath) as? HederGroupTableViewCell else { fatalError("xib does not exists") }
            cell.competitionName.text = competition.name
            return cell
        case let .Game (game) :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier, for: indexPath) as? GameTableViewCell else { fatalError("xib does not exists") }
            
            if game.gameStatus == 2 {
                cell.configureFutureGameCell(with: game)
            } else if game.gameStatus == 3 {
                cell.configureFinishedGameCell(with: game)
            } else if game.isActive == true{
                cell.configureLiveGameCell(with: game)
            }
            
            return cell
        }
    }
}

