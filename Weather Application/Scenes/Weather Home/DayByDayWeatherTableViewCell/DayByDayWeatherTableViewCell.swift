//
//  DayByDayWeatherTableViewCell.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 22/01/2022.
//

import UIKit

class DayByDayWeatherTableViewCell: UITableViewCell, DequeueInitializable {
    
    private var weatherIcon = UIImageViewFactory.createImageView()
    
    private var dateLabel = UILabelFactory.createUILabel(with: .black,font: UIFont.systemFont(ofSize: 20, weight: .semibold), alignment: .center, numberOfLines: 0, adjustFontSize: true)
    
    private var descriptionLabel = UILabelFactory.createUILabel(with: .black,font: UIFont.systemFont(ofSize: 14, weight: .regular), alignment: .center, numberOfLines: 0, adjustFontSize: true)
    
    private var dayDescriptionStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fill, spacing: 5)
    
    private var tempratureMinTitle = UILabelFactory.createUILabel(with: .black,font: UIFont.systemFont(ofSize: 16, weight: .semibold), alignment: .center, numberOfLines: 0, text: "Min",adjustFontSize: true)
    private var tempratureMinLabel = UILabelFactory.createUILabel(with: .black,font: UIFont.systemFont(ofSize: 16, weight: .regular), alignment: .center, numberOfLines: 0, adjustFontSize: true)
    private var minTempStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fill, spacing: 5)
    
    private var tempratureMaxTitle = UILabelFactory.createUILabel(with: .black,font: UIFont.systemFont(ofSize: 16, weight: .semibold), alignment: .center, numberOfLines: 0, text: "Max",adjustFontSize: true)
    private var tempratureMaxLabel = UILabelFactory.createUILabel(with: .black,font: UIFont.systemFont(ofSize: 16, weight: .regular), alignment: .center, numberOfLines: 0, adjustFontSize: true)
    private var maxTempStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fill, spacing: 5)
    
    private var minMaxTempStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fill, spacing: 5)
    
    private var content: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewModel: DayByDayWeatherTableViewCellViewModel?
    
    func config(viewModel: DayByDayWeatherTableViewCellViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
    
    // MARK: Layouting
    
    override func layoutSubviews() {
        super.layoutSubviews()
        content.applyShadow()
    }
}

extension DayByDayWeatherTableViewCell {
    
    func setupViews() {
        
        addSubview(content)
        content.addSubview(weatherIcon)
        content.addSubview(dayDescriptionStack)
        dayDescriptionStack.addArrangedSubview(dateLabel)
        dayDescriptionStack.addArrangedSubview(descriptionLabel)
        content.addSubview(minTempStack)
        minTempStack.addArrangedSubview(tempratureMinTitle)
        minTempStack.addArrangedSubview(tempratureMinLabel)
        
        content.addSubview(maxTempStack)
        maxTempStack.addArrangedSubview(tempratureMaxTitle)
        maxTempStack.addArrangedSubview(tempratureMaxLabel)
        
        content.addSubview(minMaxTempStack)
        minMaxTempStack.addArrangedSubview(minTempStack)
        minMaxTempStack.addArrangedSubview(maxTempStack)
    }
    
    func setupConstraints() {
        
        content.alignEdgesWithSuperview([.left,.top,.right,.bottom], constant: 3)
        
        weatherIcon
            .alignEdgesWithSuperview([.left, .top, .bottom], constant: 20)
            .height(constant: 70)
            .aspectRatio()
        
        dayDescriptionStack
            .toRightOf(weatherIcon, constant: 10)
            .verticallyCenterWith(weatherIcon)
            .height(constant: 70)
            

        minMaxTempStack
            .alignEdgeWithSuperview(.right, constant: 20)
            .toRightOf(dayDescriptionStack, constant: 5)
            .width(constant: 100)
            .centerVerticallyInSuperview()
        
    }
    
    func bind() {
        viewModel?.bindData(completionHandler: {[unowned self] (tempMin, tempMax, description, time, image) in
            self.tempratureMinLabel.text = tempMin
            self.tempratureMaxLabel.text = tempMax
            self.dateLabel.text = time
            self.descriptionLabel.text = description
            self.weatherIcon.image = UIImage(named: image)
        })
    }
    
}
