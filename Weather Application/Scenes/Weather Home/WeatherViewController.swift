//
//  WeatherViewController.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private var hourlyWeatherView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var textField = StaticTextFieldFactory.createField(title: "Search", isEditable: true)
    private var searchButton = UIButtonFactory.createButton()
    
    private var tabButton1 = UIButtonFactory.createButton(title: "Rio de Janeiro", backgroundColor: .clear, textColor: .black)
    private var tabButton2 = UIButtonFactory.createButton(title: "Beijing", backgroundColor: .clear, textColor: .black)
    private var tabButton3 = UIButtonFactory.createButton(title: "Los Angeles", backgroundColor: .clear, textColor: .black)
    
    private var lowerSeperatorRDG: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var lowerSeperatorBeining: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var lowerSeperatorLA: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var RDGTabStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fillProportionally, spacing: 4)
    private var BeijingStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fillProportionally, spacing: 4)
    private var LAStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fillProportionally, spacing: 4)
    
    private var tabStack = UIStackViewFactory.createStackView(with: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 5)
    
    private var hourlyTitleText = UILabelFactory.createUILabel(with: .black, font: UIFont.systemFont(ofSize: 23, weight: .bold), alignment: .left, numberOfLines: 0, lineBreakMode: .byWordWrapping, text: "Rio De Jenerio")
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return collectionView
    }()
    
    private var upcomingTitleText = UILabelFactory.createUILabel(with: .black, font: UIFont.systemFont(ofSize: 23, weight: .bold), alignment: .left, numberOfLines: 0, lineBreakMode: .byWordWrapping, text: "Upcoming Days")
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Properties
    private var viewModel: WeatherViewModel
    
    // MARK: - Init
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.viewModel.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        title = "Weather Application"
        registerCells()
        setupViews()
        setupConstraints()
    }
}

private extension WeatherViewController {
    
    func registerCells() {
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.reuseableIdentifier)
        tableView.register(DayByDayWeatherTableViewCell.self, forCellReuseIdentifier: DayByDayWeatherTableViewCell.reuseableIdentifier)
    }
    
    func setupViews(){
        view.addSubview(tabStack)
        tabStack.addArrangedSubview(RDGTabStack)
        tabStack.addArrangedSubview(BeijingStack)
        tabStack.addArrangedSubview(LAStack)
        RDGTabStack.addArrangedSubview(tabButton1)
        RDGTabStack.addArrangedSubview(lowerSeperatorRDG)
        
        BeijingStack.addArrangedSubview(tabButton2)
        BeijingStack.addArrangedSubview(lowerSeperatorBeining)
        

        LAStack.addArrangedSubview(tabButton3)
        LAStack.addArrangedSubview(lowerSeperatorLA)
        
        view.addSubview(hourlyWeatherView)
        hourlyWeatherView.addSubview(hourlyTitleText)
        hourlyWeatherView.addSubview(collectionView)
        
        view.addSubview(upcomingTitleText)
        view.addSubview(tableView)
        
        view.addSubview(textField)
        view.addSubview(searchButton)
        
        setupButtons()
    }
    
    func setupButtons() {
        
        searchButton.setImage(UIImage(named: "icon_search"), for: .normal)
        
        tabButton1.addTarget(self, action: #selector(firstTabSelected), for: .touchUpInside)
        tabButton2.addTarget(self, action: #selector(secondTabSelected), for: .touchUpInside)
        tabButton3.addTarget(self, action: #selector(thirdTabSelected), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        textField
            .alignEdgesWithSuperview([.left, .top], constants: [20, 100])

        
        searchButton
            .toRightOf(textField, constant: 15)
            .width(constant: 40)
            .aspectRatio()
            .alignEdgesWithSuperview([.right], constants: [20])
            .verticallyCenterWith(textField)
        
        tabStack
            .alignEdgesWithSuperview([.left,.right], constant: 10)
            .toBottomOf(textField, constant: 5)
            .height(constant: 50)
        
        tabButton1
            .alignEdgesWithSuperview([.left,.right, .top])
        
        lowerSeperatorRDG
            .alignEdgesWithSuperview([.left,.right,.bottom])
            .height(constant: 1)
        
        tabButton2
            .alignEdgesWithSuperview([.left,.right, .top])
        
        lowerSeperatorBeining
            .alignEdgesWithSuperview([.left,.right,.bottom])
            .height(constant: 1)
        
        tabButton3
            .alignEdgesWithSuperview([.left,.right, .top])
        
        lowerSeperatorLA
            .alignEdgesWithSuperview([.left,.right,.bottom])
            .height(constant: 1)
        
        hourlyWeatherView
            .toBottomOf(tabStack)
            .alignEdgesWithSuperview([.left, .right], constants: [10, 5])
            .height(constant: 250)
        
        hourlyTitleText
            .alignEdgesWithSuperview([.left, .top], constant: 20)
        
        collectionView
            .toBottomOf(hourlyTitleText)
            .alignEdgesWithSuperview([.left,.right,.bottom], constant: 20)
        
        upcomingTitleText
            .toBottomOf(collectionView)
            .alignEdgeWithSuperview(.left, constant: 20)
        
        tableView
            .toBottomOf(upcomingTitleText, constant: 20)
            .alignEdgesWithSuperview([.left,.right, .bottom])
    }
    
    @objc
    func firstTabSelected() {
        viewModel.tabSelected(1)
        lowerSeperatorRDG.backgroundColor = .red
        lowerSeperatorBeining.backgroundColor = .clear
        lowerSeperatorLA.backgroundColor = .clear
        
        hourlyTitleText.text = "Rio De Jenerio"
    }
    
    @objc
    func secondTabSelected() {
        viewModel.tabSelected(2)
        lowerSeperatorRDG.backgroundColor = .clear
        lowerSeperatorBeining.backgroundColor = .red
        lowerSeperatorLA.backgroundColor = .clear
        
        hourlyTitleText.text = "Beijing"
    }
    
    @objc
    func thirdTabSelected() {
        viewModel.tabSelected(3)
        lowerSeperatorRDG.backgroundColor = .clear
        lowerSeperatorLA.backgroundColor = .red
        lowerSeperatorBeining.backgroundColor = .clear
        
        hourlyTitleText.text = "Los Angeles"
    }
    
    @objc
    func searchClicked() {
        if textField.text?.count ?? 0  < 3 { return }
        viewModel.fetchWeatherByCityName(searchedCityName: textField.text ?? "")
        lowerSeperatorRDG.backgroundColor = .clear
        lowerSeperatorLA.backgroundColor = .clear
        lowerSeperatorBeining.backgroundColor = .clear
        textField.endEditing(true)
        hourlyTitleText.text = textField.text
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getHourlyCellCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = HourlyWeatherCollectionViewCellViewModel(hourlyData: viewModel.getCellViewModel(index: indexPath.row))
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.reuseableIdentifier, for: indexPath) as! HourlyWeatherCollectionViewCell
        cell.config(viewModel: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 150)
    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDaysCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVm = DayByDayWeatherTableViewCellViewModel(dayByDayData: viewModel.getDaysCellViewModel(index: indexPath.row))
        let cell = tableView.dequeueReusableCell(withIdentifier: DayByDayWeatherTableViewCell.reuseableIdentifier) as! DayByDayWeatherTableViewCell
        cell.config(viewModel: cellVm)
        return cell
    }
}

extension WeatherViewController: PopulateData {
    
    func refreshData() {
        DispatchQueue.main.async {[unowned self] in
            self.collectionView.reloadData()
            self.tableView.reloadData()
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}


