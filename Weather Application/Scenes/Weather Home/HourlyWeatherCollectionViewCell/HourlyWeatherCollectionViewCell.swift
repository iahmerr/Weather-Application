//
//  HourlyWeatherCollectionViewCell.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell, DequeueInitializable {
    
    private var tempratureLabel = UILabelFactory.createUILabel(with: .black,font: UIFont.systemFont(ofSize: 20, weight: .semibold), alignment: .center, numberOfLines: 0, adjustFontSize: true)
    
    private var humidityPercentage = UILabelFactory.createUILabel(with: .systemBlue ,font: UIFont.systemFont(ofSize: 14, weight: .regular), alignment: .center, numberOfLines: 0, adjustFontSize: true)
    
    private var weatherImage = UIImageViewFactory.createImageView()
    
    private var timeLabel = UILabelFactory.createUILabel(with: .systemBlue ,font: UIFont.systemFont(ofSize: 12, weight: .regular), alignment: .center, numberOfLines: 0, adjustFontSize: true)
    
    private var stack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .equalSpacing, spacing: 5)
    
    private var content: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewModel: HourlyWeatherCollectionViewCellViewModel?
    
    func config(viewModel: HourlyWeatherCollectionViewCellViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.content.applyShadow()
    }
}

extension HourlyWeatherCollectionViewCell {
    
    func setupViews() {
        addSubview(content)
        content.addSubview(stack)
        stack.addArrangedSubview(tempratureLabel)
        stack.addArrangedSubview(humidityPercentage)
        stack.addArrangedSubview(weatherImage)
        stack.addArrangedSubview(timeLabel)
    }
    
    func setupConstraints() {
        
        content.alignAllEdgesWithSuperview()
        
        stack
         .alignEdgesWithSuperview([.left, .right, .bottom, .top], constants:[0,0,5,5])
         
        weatherImage
          .height(constant: 50)
          .width(constant: 50)
    }
}

extension HourlyWeatherCollectionViewCell {
    
    //MARK: BindData
    
    func bind() {
        viewModel?.bindData(completionHandler: {[unowned self] (temp, humidity, time, image) in
            self.tempratureLabel.text = temp
            self.humidityPercentage.text = humidity
            self.timeLabel.text = time
            self.weatherImage.image = UIImage(named: image)
        })
    }
}

