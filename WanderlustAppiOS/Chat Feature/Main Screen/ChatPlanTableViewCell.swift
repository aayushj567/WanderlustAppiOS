import UIKit

class ChatPlanTableViewCell: UITableViewCell {
    
    let planNameLabel: UILabel = {
        let label = UILabel()
        // Customize label properties if needed
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(planNameLabel)
        planNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            planNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            planNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            planNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
