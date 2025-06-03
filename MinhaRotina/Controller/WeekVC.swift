import UIKit

class WeekVC: UIViewController {
    
    let weekDays = [Day(name: "Dom", isSelected: false), Day(name: "Seg", isSelected: false), Day(name: "Ter", isSelected: false), Day(name: "Qua", isSelected: false), Day(name: "Qui", isSelected: false), Day(name: "Sex", isSelected: false), Day(name: "Sáb", isSelected: false)]
    
    lazy var dayCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createSectionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        //collectionView.delegate = self
        collectionView.register(CollectionViewCellDay.self, forCellWithReuseIdentifier: CollectionViewCellDay.identifier)
        collectionView.backgroundColor = .backgroundLavanda
        return collectionView
    }()
    
    lazy var addTaskButton: UIBarButtonItem = {
       let button = UIBarButtonItem(
        image: UIImage(systemName: "plus"),
        style: .plain,
        target: self,
        action: #selector(addTaskTapped)
       )
        button.tintColor = .titleLavanda
        return button
    }()
    
    @objc func addTaskTapped() {
        let newTaskVC = NewTaskVC()
        newTaskVC.modalPresentationStyle = .pageSheet
        let nav = UINavigationController(rootViewController: newTaskVC)
        
        present(nav, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundLavanda
        navigationItem.rightBarButtonItem = addTaskButton
        navigationItem.title = "Minha Semana"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(.titleLavanda)
        ]
        addSubViews()
        setUptConstraints()
    }
}

// MARK: - Layout
extension WeekVC {
    func createSectionLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(61), heightDimension: .absolute(36))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - DataSource
extension WeekVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellDay.identifier, for: indexPath) as? CollectionViewCellDay else {fatalError()}
    
        cell.labelDayOfTheWeek.text = weekDays[indexPath.item].name
        
        return cell
    }
}

// MARK: - View Code
extension WeekVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(dayCollectionView)
    }
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            dayCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dayCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            dayCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            dayCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

