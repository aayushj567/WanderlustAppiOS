import UIKit
 
class ShowProfileView: UIView {
    
    var imageView: UIImageView!
    var labelName: UILabel!
    var labelEmail: UILabel!
    var tabBarView: UIView!
    var backgroundImage: UIImageView!
    var onIconTapped: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupImage()
        setupLabelName()
        setupLabelEmail()
        setupTabBarView()
        setupBackgroundImage()
        initConstraints()
    }
    
    func setupImage(){
        imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .black
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setRounded()
        self.addSubview(imageView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.textAlignment = .center
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.font = UIFont.boldSystemFont(ofSize: 24.0)
        self.addSubview(labelName)
    }
    
    func setupLabelEmail(){
        labelEmail = UILabel()
        labelEmail.textAlignment = .center
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelEmail)
    }
    
    func setupBackgroundImage(){
                    backgroundImage = UIImageView(frame: UIScreen.main.bounds)
                    backgroundImage.image = UIImage(named: "Image")
                    backgroundImage.contentMode = .scaleAspectFill // Adjust content mode as needed
                    backgroundImage.clipsToBounds = true // Clip to bounds to avoid image overflow
                    backgroundImage.alpha = 0.4
                    // Add the UIImageView as the background of the view
                    self.addSubview(backgroundImage)
                    self.sendSubviewToBack(backgroundImage)
        }
        
        func setupTabBarView() {
            tabBarView = UIView()
            tabBarView.translatesAutoresizingMaskIntoConstraints = false
            tabBarView.backgroundColor = .white
            addSubview(tabBarView)
            
            // Create a stack view for the icons
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.distribution = .fillEqually // This will distribute the space equally among the icons
            stackView.alignment = .center
            stackView.axis = .horizontal
            tabBarView.addSubview(stackView)
            
            // Add constraints to the stack view
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor),
                stackView.topAnchor.constraint(equalTo: tabBarView.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: tabBarView.bottomAnchor)
            ])
            
            // Initialize icon views and add them to the stack view
            let iconNames = ["house", "list.bullet", "message", "person.crop.circle"]
            for (index, iconName) in iconNames.enumerated() {
                let iconImageView = UIImageView(image: UIImage(systemName: iconName))
                iconImageView.contentMode = .scaleAspectFit
                iconImageView.isUserInteractionEnabled = true
                iconImageView.tag = index  // Set the tag to the index of the iconName
                
                // Add a gesture recognizer to each icon
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabBarIconTapped(_:)))
                iconImageView.addGestureRecognizer(tapGesture)
                
                stackView.addArrangedSubview(iconImageView)
            }
        }
        
        @objc func tabBarIconTapped(_ sender: UITapGestureRecognizer) {
                    guard let iconView = sender.view else { return }
                    let index = iconView.tag
                    // The view controller that holds this view will set this closure to handle the icon tap.
                    onIconTapped?(index)
                }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            
            labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            labelName.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 40),
            labelEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            labelEmail.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tabBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        tabBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
                        tabBarView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 35),
                        tabBarView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

