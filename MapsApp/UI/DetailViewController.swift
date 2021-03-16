//
//  DetailViewController.swift
//  MapTest
//
//  Created by Михаил Задорожный on 16.03.2021.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    lazy var backdropView: UIView = UIView(frame: self.view.bounds)
    let menuView = UIView()
    let imageMenuView = UIView()
    let infoMenuView = UIView()
    let imageView = UIImageView()
    let menuHeight = UIScreen.main.bounds.height / 4
    let nameLabel = UILabel()
    let gpsImage = UIImageView()
    let gpsLabel = UILabel()
    let calendarImage = UIImageView()
    let calendarLabel = UILabel()
    let timeImage = UIImageView()
    let timeLabel = UILabel()
    let stackView = UIStackView()
    let historyButton = UIButton()
    var person: Person!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupMainView()
        setupImageMenuView()
        setupInfoMenuView()
    }
    
    private func setupMainView() {
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(menuView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        backdropView.addGestureRecognizer(tapGesture)
        backdropView.backgroundColor = .clear
        
        menuView.backgroundColor = .white
        menuView.addSubview(imageMenuView)
        menuView.snp.makeConstraints { (make) in
            make.height.equalTo(menuHeight)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    private func setupImageMenuView() {
        
        imageMenuView.backgroundColor = .white
        imageMenuView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(view.bounds.width / 4)
        }
        
        imageMenuView.addSubview(imageView)
        imageView.image = ImageCreator.createIconImage(imageName: person.imgName)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(100)
        }
    }
    
    private func setupInfoMenuView() {
        
        menuView.addSubview(infoMenuView)
        infoMenuView.backgroundColor = .white
        infoMenuView.addSubview(nameLabel)
        infoMenuView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(3 * (view.bounds.width / 4))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        nameLabel.text = person.name
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 24)
        setupStackView()
    }
    
    private func setupStackView() {
        
        infoMenuView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(16)
        }
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .clear
        stackView.addArrangedSubview(gpsImage)
        stackView.addArrangedSubview(gpsLabel)
        stackView.addArrangedSubview(calendarImage)
        stackView.addArrangedSubview(calendarLabel)
        stackView.addArrangedSubview(timeImage)
        stackView.addArrangedSubview(timeLabel)
        
        gpsImage.image = UIImage(named: "gps")
        gpsLabel.text = "GPS"
        gpsLabel.textColor = .black
        gpsImage.snp.makeConstraints { (make) in
            make.width.equalTo(16)
        }
        
        calendarLabel.text = person.date
        calendarLabel.textColor = .black
        calendarImage.image = UIImage(named: "calendar")
        calendarImage.snp.makeConstraints { (make) in
            make.width.equalTo(16)
        }
        
        timeImage.image = UIImage(named: "clock")
        timeLabel.text = person.time
        timeLabel.textColor = .black
        timeImage.snp.makeConstraints { (make) in
            make.width.equalTo(16)
        }
        
        infoMenuView.addSubview(historyButton)
        historyButton.setTitle("Посмотреть историю", for: .normal)
        historyButton.backgroundColor = .blue
        historyButton.layer.cornerRadius = 25
        historyButton.layer.masksToBounds = true
        historyButton.addTarget(self, action: #selector(viewHistory), for: .touchUpInside)
        historyButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(8)
            make.left.equalToSuperview().offset(8)
            make.height.equalTo(50)
            make.top.equalTo(stackView.snp.bottom).offset(16)
        }
    }
    
    @objc func viewHistory() {
        let alert = UIAlertController(title: "Просмотр истории недоступен", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
