//
//  APIService.swift
//  365ScoreTest
//
//  Created by Nikita Koniukh on 03/09/2021.
//

import Foundation


enum ValidationError: Error {
    case urlError
    case serverError(statusCode: Int)
    case generalError(String)
    case decodingError(String)
    case noData
}

enum GamesResult {
    case success([[Game]], [[GameListEnum]]), failure(ValidationError)
}

class APIService {
    
    func fetcChampionship(completion: @escaping(GamesResult) -> Void) {
        
        guard let url = URL(string: Constants.assignmentUrlString) else {
            completion(.failure(.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            if let error = error {
                completion(.failure(.generalError(error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            
            do {
                let championshipResult: Games = try JSONDecoder().decode(Games.self, from: data)
                
                let games = sortItemsByDate( championshipResult.games, inputFormat: "dd-MM-yyyy HH:mm")
                
                let groupedGamesBySections = games.reduce(into: []) {
                    $0.last?.last?.dateTime ==  $1.dateTime ?
                        $0[$0.index(before: $0.endIndex)].append($1) :
                        $0.append([$1])
                }
                
                let gameListEnum = setGameListEnum(with: games, competitions: championshipResult.competitions)
                
                DispatchQueue.main.async {
                    completion(.success(groupedGamesBySections, gameListEnum))
                }
                
            } catch {
                completion(.failure(.decodingError("\(error)")))
            }
            
        }
        task.resume()
    }
    
    private func setGameListEnum(with games: [Game], competitions: [Competition]) -> [[GameListEnum]] {
        var enumArray = [GameListEnum]()
        var groupedEnumArray = [[GameListEnum]]()
        
        for (index, item) in games.enumerated() {
            if index == 0 {
                enumArray.append(GameListEnum.Competition(self.getCompetitionObject(by: item.competitionId, competitionArray: competitions)!))
                enumArray.append(GameListEnum.Game(item))
            } else {
                if index != 0 && games[index - 1].competitionId != item.competitionId
                {
                    groupedEnumArray.append(enumArray)
                    enumArray = [GameListEnum]()
                    enumArray.append(GameListEnum.Competition(self.getCompetitionObject(by: item.competitionId, competitionArray: competitions)!))
                    enumArray.append(GameListEnum.Game(item))
                } else {
                    enumArray.append(GameListEnum.Game(item))
                }
            }
            if index == games.count - 1 {
                groupedEnumArray.append(enumArray)
            }
        }
        return groupedEnumArray
    }
    
    private func getCompetitionObject(by id: Int, competitionArray: [Competition]) -> Competition? {
        guard let competitionArray = competitionArray.first(where: {$0.id == id}) else {
          return nil
        }
        return competitionArray
    }
    
    
    

    
    
    
}
