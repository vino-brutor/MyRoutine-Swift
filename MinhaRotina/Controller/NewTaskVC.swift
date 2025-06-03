//
//  NewTaskVC.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 29/05/25.
//

import UIKit

class NewTaskVC: UIViewController {
    
    //dia das semana apara a collection view
    var weekDays: [DayItemInNewTask] = [
        .init(name: "Segunda", isSelected: false),
        .init(name: "Terça", isSelected: false),
        .init(name: "Quarta", isSelected: false),
        .init(name: "Quinta", isSelected: false),
        .init(name: "Sexta", isSelected: false),
        .init(name: "Sábado", isSelected: false),
        .init(name: "Domingo", isSelected: false)
    ]
    
    //array com os icones da collectio view
    var taskIcons: [Icons] = [
        .init(name: "Sol", icon: UIImage(systemName: "sun.max") ?? UIImage(), isSelected: false),
        .init(name: "Lua", icon: UIImage(systemName: "moon") ?? UIImage(), isSelected: false),
        .init(name: "Café", icon: UIImage(systemName: "cup.and.saucer") ?? UIImage(), isSelected: false),
        .init(name: "Livro", icon: UIImage(systemName: "book") ?? UIImage(), isSelected: false),
        .init(name: "Halter", icon: UIImage(systemName: "dumbbell") ?? UIImage(), isSelected: false),
        .init(name: "Maleta", icon: UIImage(systemName: "briefcase") ?? UIImage(), isSelected: false),
        .init(name: "Pessoas", icon: UIImage(systemName: "person.2") ?? UIImage(), isSelected: false),
        .init(name: "Coração", icon: UIImage(systemName: "heart") ?? UIImage(), isSelected: false),
        .init(name: "Música", icon: UIImage(systemName: "music.note") ?? UIImage(), isSelected: false),
        .init(name: "Filme", icon: UIImage(systemName: "film") ?? UIImage(), isSelected: false),
        .init(name: "Compras", icon: UIImage(systemName: "bag") ?? UIImage(), isSelected: false),
        .init(name: "Carro", icon: UIImage(systemName: "car") ?? UIImage(), isSelected: false)
    ]
    
    lazy var newTaskCollectionView: UICollectionView = {
        //declarando collection view
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .backgroundLavanda

        //registrando as celulas
        collectionView.register(CollectionViewCellNewTaskName.self, forCellWithReuseIdentifier: CollectionViewCellNewTaskName.identifier)
        collectionView.register(CollectionViewCellWeekPicker.self, forCellWithReuseIdentifier: CollectionViewCellWeekPicker.identifier)
        collectionView.register(CollectionViewCellTaskTIme.self, forCellWithReuseIdentifier: CollectionViewCellTaskTIme.reuseIdentifier)
        collectionView.register(CollectionViewCellTaskIcon.self, forCellWithReuseIdentifier: CollectionViewCellTaskIcon.reuseIdentifier)

        return collectionView
    }()

    //botao para sair da modal
    lazy var exitButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "x.circle"),
            style: .plain,
            target: self,
            action: #selector(exitTapped)
        )
        button.tintColor = .titleLavanda
        return button
    }()
    
    @objc func exitTapped() {
        print("Exit tapped")
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundLavanda
        self.title = "Nova Rotina"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(.titleLavanda),
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        navigationItem.rightBarButtonItem = exitButton
        addSubViews()
        setUptConstraints()
        
    }
    
}

extension NewTaskVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return newTaskSection.allCases.count //numero de secoes baseado em quantos inputs tem
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let inpuType = newTaskSection(rawValue: section) else { return 0 }
        
        switch inpuType {
            case .taskName: return 1
            case .dayOfWeek: return weekDays.count
            case .taskTime: return 1
            case .taskIcon: return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = newTaskSection(rawValue: indexPath.section) else {
            fatalError("Section inválida")
        }

        switch section {
        //secao 0
        case .taskName:
            print("Montando célula de taskName")
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewCellNewTaskName.identifier,
                for: indexPath
            ) as? CollectionViewCellNewTaskName else {
                fatalError("Erro ao dequeuer CollectionViewCellNewTaskName")
            }
            return cell
        
        //secao 1
        case .dayOfWeek:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionViewCellWeekPicker.identifier,
                for: indexPath
            ) as? CollectionViewCellWeekPicker else {
                fatalError("Erro ao dequeuer CollectionViewCellNewTaskDayOfWeek")
            }
            cell.config(with: weekDays[indexPath.item])
            return cell
            
        //secao 2
        case .taskTime:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTaskTIme.reuseIdentifier, for: indexPath) as? CollectionViewCellTaskTIme else {
                fatalError("Erro ao dequer CollectionViewCellTaskTIme")
            }
            return cell
            
        //secao 3
        case.taskIcon:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTaskIcon.reuseIdentifier, for: indexPath) as? CollectionViewCellTaskIcon else {
                fatalError("Erro ao dequer CollectionViewCellTaskTIme")
            }
            
            cell.config(with: taskIcons[indexPath.item])
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    
}

extension NewTaskVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            for i in 0..<weekDays.count {
                weekDays[i].isSelected = (i == indexPath.item)
            }
            
            collectionView.reloadSections(IndexSet(integer: 1))
        }
        
        if indexPath.section == 3 {
            for i in 0..<taskIcons.count {
                taskIcons[i].isSelected = (i == indexPath.item)
                
                collectionView.reloadSections(IndexSet(integer: 3))
            }
        }
    }
}

extension NewTaskVC {
    
    func createLayoutSection0() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(56))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section =  NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        return section
    }
    
    func createLayoutSection1() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let gorup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section =  NSCollectionLayoutSection(group: gorup)
        section.interGroupSpacing = 12
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        return section
        
    }
    
    func createLayoutSection2() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        return section
    }
    
    func createLayoutSection3() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(58))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
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
            case 2:
                return self.createLayoutSection2()
            case 3:
                return self.createLayoutSection3()
            default:
                return nil
            }
            
        }
        
        return layout
    }
}

extension NewTaskVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(newTaskCollectionView)
    }
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            newTaskCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newTaskCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newTaskCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newTaskCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}


