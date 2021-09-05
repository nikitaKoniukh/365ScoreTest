//
//  HederGroupTableViewCell.swift
//  365ScoreTest
//
//  Created by Nikita Koniukh on 03/09/2021.
//

import UIKit

class HederGroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var competitionName: UILabel!
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        competitionName.text = nil
    }
    
}
