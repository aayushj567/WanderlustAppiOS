//
//  PlansView.swift
//  WanderlustAppiOS
//
//  Created by Aayush Jaiswal on 4/5/24.
//

import UIKit

class CalendarView: UIView {

    var topLabel: UILabel!
    var planTextField: UITextField!
    var calendarView: UICalendarView!
    var buttonNext: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topLabel = UILabel()
        topLabel.text = " Enter plan name "
        topLabel.layer.cornerRadius = 6
        topLabel.layer.masksToBounds = true
        topLabel.backgroundColor = #colorLiteral(red: 0.7267350554, green: 0.6507179737, blue: 0.6439473033, alpha: 1)
        topLabel.font = UIFont.italicSystemFont(ofSize: 16)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topLabel)
        
        planTextField = UITextField()
        planTextField.placeholder = "e.g. My Summer 2024 trip!"
        planTextField.translatesAutoresizingMaskIntoConstraints = false
        planTextField.borderStyle = .roundedRect
        planTextField.layer.borderWidth = 1.0
        planTextField.layer.cornerRadius = 5.0
        planTextField.layer.borderColor = UIColor.gray.cgColor
        planTextField.autocapitalizationType = .none
        planTextField.autocorrectionType = .no
        self.addSubview(planTextField)
        
        calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        self.addSubview(calendarView)
        
        buttonNext = UIButton(type: .system)
        buttonNext.translatesAutoresizingMaskIntoConstraints = false
        buttonNext.setTitle("Next", for: .normal)
        buttonNext.setTitleColor(.white, for: .normal)
        buttonNext.backgroundColor = .systemBlue
        buttonNext.layer.cornerRadius = 5
        self.addSubview(buttonNext)
        
        
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            planTextField.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor, constant: 10),
            planTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            planTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            calendarView.topAnchor.constraint(equalTo: self.planTextField.bottomAnchor, constant: 10),
            calendarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 500),
            
            buttonNext.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                buttonNext.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                buttonNext.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                buttonNext.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

