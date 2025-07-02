import UIKit
import CoreData

class WeekVC: UIViewController {
    
    var isDragginTask: Bool = false
    var selectedDay: String = ""
    
    var weekDays = [Day(name: "Dom", isSelected: false), Day(name: "Seg", isSelected: false), Day(name: "Ter", isSelected: false), Day(name: "Qua", isSelected: false), Day(name: "Qui", isSelected: false), Day(name: "Sex", isSelected: false), Day(name: "Sáb", isSelected: false)]
    
    lazy var dayCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.register(CollectionViewCellDay.self, forCellWithReuseIdentifier: CollectionViewCellDay.identifier)
        collectionView.register(CollectionViewCellTaskOfTheDay.self, forCellWithReuseIdentifier: CollectionViewCellTaskOfTheDay.identifier)
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
        navigationItem.title = "Minha Semana"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.backgroundLavanda
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.titleLavanda,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        navigationItem.rightBarButtonItem = addTaskButton
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        addSubViews()
        setUptConstraints()
        setTodayAsCurrentDay()
    }
    
    func setTodayAsCurrentDay(){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "E"
        
        let todayName = formatter.string(from: Date()).capitalized
        print(todayName)
        
        for i in 0..<weekDays.count {
            weekDays[i].isSelected = ((weekDays[i].name + ".") == todayName) //ve qual o dia se iguala ao dia de hoje
        }
        
        DispatchQueue.main.async {
            if let index = self.weekDays.firstIndex(where: { ($0.name + ".") == todayName }){
                self.selectedDay = self.weekDays[index].name
                let indexPath = IndexPath(item: index, section: 0)
                self.dayCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                self.dayCollectionView.reloadSections(IndexSet(integer: 1))
            }
        }
    }
    
    @objc func refreshTasks() {
        dayCollectionView.reloadSections(IndexSet(integer: 1))
    }
}

// MARK: - Layout
extension WeekVC {
    
    func createLayoutSection0()  -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(61), heightDimension: .absolute(36))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    func createLayoutSection1() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(72))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        section.interGroupSpacing = 12
        
        return section
    }
    
    func createAllLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch sectionIndex {
            case 0:
                return self.createLayoutSection0()
            case 1:
                return self.createLayoutSection1()
            default:
                return nil
            }
        }
        
        return layout
    }
}

// MARK: - DataSource
extension WeekVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return weekDays.count
        }
        return Persistence.shared.getTaskByDay(by: selectedDay)?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellDay.identifier, for: indexPath) as? CollectionViewCellDay else {fatalError()}
            
            cell.config(with: weekDays[indexPath.item])
            
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTaskOfTheDay.identifier, for: indexPath) as? CollectionViewCellTaskOfTheDay else {fatalError()}
            
            let allTasksOfTheDay  = (Persistence.shared.getTaskByDay(by: selectedDay) ?? []).sorted {($0.time ?? Date()) < ($1.time ?? Date())}
            
            cell.config(with: allTasksOfTheDay[indexPath.item])
            
            let task = allTasksOfTheDay[indexPath.item]
            cell.onDeleteTapped = {
                guard let id = task.id else { return }
                
                Persistence.shared.deleteTask(by: id)
                
                // Atualize a fonte de dados
                let tasksAfter = Persistence.shared.getTaskByDay(by: self.selectedDay) ?? []
                
                self.dayCollectionView.reloadSections(IndexSet(integer: 1))
            }
            
            
            return cell
        }
    }
}

extension WeekVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section ==  0 {
            selectedDay = weekDays[indexPath.item].name
            weekDays.indices.forEach { weekDays[$0].isSelected = ($0 == indexPath.item) }

            dayCollectionView.reloadSections(IndexSet([0, 1]))
        }
    }
    
}

extension WeekVC: UICollectionViewDragDelegate, UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
         guard indexPath.section == 1,
               let task = Persistence.shared.getTaskByDay(by: selectedDay)?
                 .sorted(by: { $0.orderIndex < $1.orderIndex })[indexPath.item] else {
             return []
         }
         let provider = NSItemProvider(object: task.id!.uuidString as NSString)
         let item = UIDragItem(itemProvider: provider)
         item.localObject = task
         return [item]
     }

     func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
         guard coordinator.proposal.operation == .move,
               let dest = coordinator.destinationIndexPath,
               let item = coordinator.items.first,
               let source = item.sourceIndexPath,
               let task = item.dragItem.localObject as? Task else {
             return
         }

         collectionView.performBatchUpdates {
             var tasks = Persistence.shared.getTaskByDay(by: selectedDay)?
                 .sorted(by: { $0.orderIndex < $1.orderIndex }) ?? []

             tasks.remove(at: source.item)
             tasks.insert(task, at: dest.item)
             Persistence.shared.updateTaskOrder(for: selectedDay, newOrder: tasks)
             collectionView.reloadItems(at: [source, dest])
         }

         coordinator.drop(item.dragItem, toItemAt: dest)
     }

     func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession,
                         withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
         return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
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
            dayCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

