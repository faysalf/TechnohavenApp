//
//  TransactionTvCell.swift
//  TechnohavenApp
//
//  Created by Faysal Ahmed on 11/2/26.
//

import UIKit

class TransactionTvCell: UITableViewCell {
    static let IDENTIFIER = "transaction_list_tv_cell_identifier"

    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override
    func awakeFromNib() {
        super.awakeFromNib()

    }

    override
    func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with transaction: TransactionModel) {
        titelLabel.text = transaction.title
        amountLabel.text = "Tk \(transaction.amount)"
        dateLabel.text = DateHelper.displayFormatter.string(from: transaction.date)
    }
    
}
