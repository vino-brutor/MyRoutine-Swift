//
//  NewTaskVC.swift
//  MinhaRotina
//
//  Created by Vítor Bruno on 29/05/25.
//

import UIKit

class NewTaskVC: UIViewController {
    
    
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
        collectionView.register(CollectionViewCellColors.self, forCellWithReuseIdentifier: CollectionViewCellColors.reuseIdentifier)

        //registro do header
        collectionView.register(SectionHeaderNewTask.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderNewTask.reuseIdentifier)
        
        return collectionView
    }()
    
    //botao de criar rotina
    lazy var createRoutineButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar Rotina", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .selectedLavanda
        button.layer.cornerRadius = 24
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(createRoutineTapped), for: .touchUpInside)
        return button
    }()

    @objc func createRoutineTapped() {
        print("Rotina criada! 🎉")
    }
    
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
            case .taskColor: return taskColorsList.count
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
        case .taskIcon:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTaskIcon.reuseIdentifier, for: indexPath) as? CollectionViewCellTaskIcon else {
                fatalError("Erro ao dequer CollectionViewCellTaskTIme")
            }
            
            cell.config(with: taskIcons[indexPath.item])
            
            return cell
        
        //secao 4
        case .taskColor:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellColors.reuseIdentifier, for: indexPath) as? CollectionViewCellColors else {
                fatalError("Erro ao dequer CollectionViewCellTaskTIme")
            }
            
            cell.config(with: taskColorsList[indexPath.item])
            
            return cell
        
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderNewTask.reuseIdentifier, for: indexPath) as! SectionHeaderNewTask
        
        switch indexPath.section {
        case 1:
            header.titleLabel.text = "Dia da semana"
            return header
        case 2:
            header.titleLabel.text = "Hora"
            return header
        case 3:
            header.titleLabel.text = "Ícone"
            return header
        case 4:
            header.titleLabel.text = "Cor"
            return header
        default:
            return UICollectionReusableView()
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
        
        if indexPath.section == 4 {
            for i in 0..<taskColorsList.count {
                taskColorsList[i].isSelected = (i == indexPath.item)
                
                collectionView.reloadSections(IndexSet(integer: 4))
                collectionView.reloadData()
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
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(36)
        )
            
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
            
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
    
    func createLayoutSection2() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(36)
        )
            
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
            
        section.boundarySupplementaryItems = [header]
        
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
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(36)
        )
            
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
            
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func createLayoutSection4() -> NSCollectionLayoutSection {
        let itemSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.15), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(36)
        )
            
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
            
        section.boundarySupplementaryItems = [header]
        
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
            case 4:
                return self.createLayoutSection4()
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
        view.addSubview(createRoutineButton)
    }
    
    func setUptConstraints() {
        NSLayoutConstraint.activate([
            newTaskCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newTaskCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newTaskCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newTaskCollectionView.bottomAnchor.constraint(equalTo: createRoutineButton.topAnchor, constant: -16),
                    
            createRoutineButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createRoutineButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createRoutineButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            createRoutineButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}


