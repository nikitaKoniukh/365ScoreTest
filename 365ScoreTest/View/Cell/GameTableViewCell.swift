//
//  GameTableViewCell.swift
//  365ScoreTest
//
//  Created by Nikita Koniukh on 03/09/2021.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var team1: UILabel!
    @IBOutlet weak var team2: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        backgroundColor = .clear
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    func configureFutureGameCell(with game: Game) {
        team1.text = game.competitorsArray[0].name
        team2.text = game.competitorsArray[1].name
        scoreLabel.text = formatDate(dateToFormat: game.dateTime,
                                     inputFormat: "dd-MM-yyyy HH:mm",
                                     outputFormat: "HH:mm")
        timeLabel.isHidden = true
    }
    
    func configureLiveGameCell(with game: Game) {
        team1.text = game.competitorsArray[0].name
        team2.text = game.competitorsArray[1].name
        scoreLabel.text = "\(game.gameScoreArray[0]):\(game.gameScoreArray[1])"
        timeLabel.text = "\(game.liveGameMinute)'"
        timeLabel.isHidden = false
    }
    
    func configureFinishedGameCell(with game: Game) {
        team1.text = game.competitorsArray[0].name
        team2.text = game.competitorsArray[1].name
        scoreLabel.text = "\(game.gameScoreArray[0]):\(game.gameScoreArray[1])"
        timeLabel.isHidden = true
    }
}
