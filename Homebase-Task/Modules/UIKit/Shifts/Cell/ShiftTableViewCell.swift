//
//  ShiftTableViewCell.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import UIKit

class ShiftTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var shiftTimeLbl: UILabel!
    @IBOutlet private weak var shapView: UIView!
    
    
    var viewModel: ShiftViewModel?{
        didSet{
            self.titleLbl.text = viewModel?.title
            self.shiftTimeLbl.text = viewModel?.timeRange
            self.shapView.backgroundColor = viewModel?.color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     self.shapView.layer.cornerRadius = self.shapView.bounds.height / 2
        

    }

    
}
