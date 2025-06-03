import UIKit

class CollectionViewCellWeekPicker: UICollectionViewCell {
    static let identifier = "CollectionViewCellWeekPicker"

    lazy var labelDay: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "SFPro", size: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(labelDay)
        contentView.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            labelDay.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelDay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelDay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(with day: DayItemInNewTask) {
        labelDay.text = day.name
        contentView.backgroundColor = day.isSelected ? .selectedLavanda : .backgroundLavanda
        labelDay.textColor = day.isSelected ? .white : .selectedLavanda
        contentView.layer.borderColor = day.isSelected ? UIColor.selectedLavanda.cgColor : UIColor.white.cgColor
        contentView.layer.borderWidth = 4
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = day.isSelected ? 0.15 : 0.0
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 4
    }
}
