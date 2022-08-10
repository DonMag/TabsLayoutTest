//
//  ViewController.swift
//  TabsLayoutTest
//
//  Created by Don Mag on 6/28/22.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	// MARK: - table view
	let tableView: UITableView = {
		let view = UITableView(frame: .zero, style: .grouped)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// set background color of tableview
		tableView.backgroundColor = .clear
		view.backgroundColor = .systemGroupedBackground
		
		// register tableview cell
		tableView.register(TabOneTableViewCell.self, forCellReuseIdentifier: "TestCellOne")
		
		// remove separator
		tableView.separatorStyle = .none
		
		// add pull to refresh
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
		tableView.refreshControl?.tintColor = .white
		
		tableView.dataSource = self
		tableView.delegate = self
		
		view.addSubview(tableView)
		
		let g = view.safeAreaLayoutGuide
		
		NSLayoutConstraint.activate([
			
			// constraints for table view
			tableView.topAnchor.constraint(equalTo: g.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: g.bottomAnchor),
			
		])
		
		let redView = UIView()
		redView.backgroundColor = .red
		redView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(redView)
		NSLayoutConstraint.activate([
			redView.topAnchor.constraint(equalTo: g.topAnchor),
			redView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 80.0),
			redView.widthAnchor.constraint(equalToConstant: 120.0),
			redView.heightAnchor.constraint(equalToConstant: 80.0),
		])
		
		tableView.backgroundColor = .yellow
		//tableView.insetsContentViewsToSafeArea = false
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return 10
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
		
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		// header view
		let headerView: UITableViewHeaderFooterView = {
			let view = UITableViewHeaderFooterView()
			return view
		}()
		
		// button
		let headerButton: UIButton = {
			let button = UIButton()
			button.setTitle("Some Settings", for: .normal)
			button.setTitleColor(UIColor.label, for: .normal)
			button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
			button.tintColor = UIColor.label
			button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
			button.contentHorizontalAlignment = .right
			button.semanticContentAttribute = .forceRightToLeft
			button.translatesAutoresizingMaskIntoConstraints = false
			return button
		}()
		
		// icon
		let headerIcon: UIImageView = {
			let image = UIImageView()
			image.image = UIImage(systemName: "bell.badge")
			image.translatesAutoresizingMaskIntoConstraints = false
			image.tintColor = .red
			image.contentMode = .scaleAspectFit
			return image
		}()
		
		view.addSubview(headerView)
		headerView.addSubview(headerIcon)
		headerView.addSubview(headerButton)
		
		// constraints
		NSLayoutConstraint.activate([
			// constraints for the header view
			headerView.topAnchor.constraint(equalTo: view.topAnchor),
			headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			headerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			// button constraints
			headerButton.topAnchor.constraint(equalTo: headerView.topAnchor),
			headerButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
			headerButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
			
			// icon constraints
			headerIcon.centerYAnchor.constraint(equalTo: headerButton.centerYAnchor),
			headerIcon.trailingAnchor.constraint(equalTo: headerButton.leadingAnchor, constant: -3),
		])
		
		return headerView
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 80
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TestCellOne", for: indexPath) as! TabOneTableViewCell
		cell.backgroundColor = UIColor.clear
		cell.selectionStyle = .none
		cell.setCellOne()
		return cell
		
	}
	
	@objc func didPullToRefresh() {
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print(tableView.contentOffset)
	}
}

class TabOneTableViewCell: UITableViewCell {
	
	// MARK: - card view
	let cardView : UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.lightGray
		view.layer.cornerRadius = 12.5
		view.layer.shadowOffset = CGSize(width: 0, height: 5)
		view.layer.shadowRadius = 5
		view.layer.shadowOpacity = 0.3
		return view
	}()
	
	// MARK: - post image view
	let postImageView: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		view.contentMode = .scaleAspectFill
		view.backgroundColor = .cyan
		view.layer.cornerRadius = 12.5
		view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		return view
	}()
	
	// MARK: - title Label
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
		return label
	}()
	
	// MARK: - date icon
	let dateIcon: UIImageView = {
		let view = UIImageView()
		view.image = UIImage(systemName: "calendar.badge.clock")
		view.contentMode = .scaleAspectFill
		view.translatesAutoresizingMaskIntoConstraints = false
		view.tintColor = UIColor.red
		return view
	}()
	
	// MARK: - date label
	let dateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		label.textColor = UIColor.red
		return label
	}()
	
	// MARK: - content preview
	let contentPreview: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		label.numberOfLines = 3
		return label
	}()
	
	func setCellOne() {
		
		// set background color of cell
		contentView.backgroundColor = .clear
		
		// add card view to contentview
		contentView.addSubview(cardView)
		
		// add views to cardview
		cardView.addSubview(titleLabel)
		cardView.addSubview(dateIcon)
		cardView.addSubview(dateLabel)
		cardView.addSubview(contentPreview)
		cardView.addSubview(postImageView)
		
		NSLayoutConstraint.activate([
			
			// constraints for card view
			cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
			cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
			cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
			cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
			
			// constraints for imageview
			postImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 0),
			postImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
			postImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0),
			postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 0.65),
			
			// constraints for date icon
			dateIcon.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 15),
			dateIcon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
			dateIcon.widthAnchor.constraint(equalToConstant: 20),
			dateIcon.heightAnchor.constraint(equalToConstant: 20),
			
			// constraints for date label
			dateLabel.centerYAnchor.constraint(equalTo: dateIcon.centerYAnchor),
			dateLabel.leadingAnchor.constraint(equalTo: dateIcon.trailingAnchor, constant: 10),
			dateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
			
			// constraints for title label
			titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
			titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
			titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
			
			// constraints for content preview
			contentPreview.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
			contentPreview.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
			contentPreview.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
			contentPreview.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
			
		])
		
		// set title label
		titleLabel.text = "This is a title"
		
		// set the content preview label
		contentPreview.text = "The content goes here. The content goes here. The content goes here. The content goes here. The content goes here. The content goes here. The content goes here. The content goes here. The content goes here. The content goes here. The content goes here. The content goes here. "
		
		// set date label
		dateLabel.text = "This is a date"
		
	}
	
}

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// set background color
		view.backgroundColor = .systemGroupedBackground
		tableView.backgroundColor = .clear
		
		// register tableview cell
		tableView.register(TabTwoTableViewCell.self, forCellReuseIdentifier: "TableCellTwo")
		
		// add pull to refresh
		tableView.refreshControl = UIRefreshControl()
		tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
		tableView.refreshControl?.tintColor = UIColor.white
		
		let g = view.safeAreaLayoutGuide
		// If all four constraints are set in storyboard, there are weird glitches with the refreshcontrol. Setting only 3 constraints in storyboard and the last one here fixed it.
//		NSLayoutConstraint.activate([
//			tableView.topAnchor.constraint(equalTo: g.topAnchor),
//		])
		
		tableView.dataSource = self
		tableView.delegate = self
		
		setTableviewFooter()
		
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		switch section {
		case 1:
			return 3
		case 2:
			return 2
		case 3:
			return 3
		default:
			return 0
		}
		
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 {
			return ""
		}
		else {
			return "Title Section \(section)"
		}
		
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		
		// only for first section
		if section == 0 {
			
			// blur effects
			let _: UIBlurEffect = {
				let blur = UIBlurEffect(style: .light)
				return blur
			}()
			let _: UIVisualEffectView = {
				let blur = UIVisualEffectView()
				return blur
			}()
			
			// header view
			let headerView: UITableViewHeaderFooterView = {
				let view = UITableViewHeaderFooterView()
				return view
			}()
			
			// button
			let headerButton: UIButton = {
				let button = UIButton()
				button.setTitle("Some settings", for: .normal)
				button.setTitleColor(UIColor.label, for: .normal)
				button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
				button.tintColor = UIColor.label
				button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
				button.contentHorizontalAlignment = .right
				button.semanticContentAttribute = .forceRightToLeft
				button.translatesAutoresizingMaskIntoConstraints = false
				return button
			}()
			
			// icon
			let headerIcon: UIImageView = {
				let image = UIImageView()
				image.image = UIImage(systemName: "calendar.badge.plus")
				image.translatesAutoresizingMaskIntoConstraints = false
				image.tintColor = .red
				image.contentMode = .scaleAspectFit
				return image
			}()
			
			view.addSubview(headerView)
			headerView.addSubview(headerIcon)
			headerView.addSubview(headerButton)
			
			// constraints
			NSLayoutConstraint.activate([
				// constraints for the header view
				headerView.topAnchor.constraint(equalTo: view.topAnchor),
				headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
				headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
				headerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
				
				// button constraints
				headerButton.topAnchor.constraint(equalTo: headerView.topAnchor),
				headerButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
				headerButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
				
				// icon constraints
				headerIcon.centerYAnchor.constraint(equalTo: headerButton.centerYAnchor),
				headerIcon.trailingAnchor.constraint(equalTo: headerButton.leadingAnchor, constant: -3),
			])
			
			// return the date
			return headerView
			
		}
		else {
			return nil
		}
		
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		return 40
		
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		return 4
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellTwo", for: indexPath) as! TabTwoTableViewCell
		cell.selectionStyle = .none
		cell.backgroundColor = .clear
		cell.accessoryType = .disclosureIndicator
		tableView.separatorStyle = .singleLine
		cell.setTestCellTwo()
		return cell
		
	}
	
	// MARK: - function for pull to refresh
	@objc private func didPullToRefresh() {
		tableView.refreshControl?.endRefreshing()
	}
	
	// MARK: - setting the footer for the table
	private func setTableviewFooter() {
		
		let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
		footerView.backgroundColor = UIColor.clear
		let footerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
		footerLabel.text = "Some text goes\nhere"
		footerLabel.numberOfLines = 0
		footerLabel.backgroundColor = .clear
		footerLabel.font = .systemFont(ofSize: 13, weight: .regular)
		footerLabel.textColor = .secondaryLabel
		footerLabel.textAlignment = .center
		footerView.addSubview(footerLabel)
		
		tableView.tableFooterView = footerView
	}
	
}

class MyCardView: UIView {}

class TabTwoTableViewCell: UITableViewCell {
	
	// MARK: - card view
	let cardView : MyCardView = {
		let view = MyCardView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .yellow
		view.layer.cornerRadius = 12.5
		view.layer.shadowOffset = CGSize(width: 0, height: 5)
		view.layer.shadowRadius = 5
		view.layer.shadowOpacity = 0.3
		return view
	}()
	
	// MARK: - stack view inside of card view
	let stackViewInCardView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.distribution = .fillProportionally
		view.alignment = .center
		view.axis = .vertical
		return view
	}()
	
	// MARK: - stack view next to card view
	let stackView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.distribution = .fillProportionally
		view.alignment = .leading
		view.axis = .vertical
		return view
	}()
	
	// MARK: - label for start date day
	let startDateDayLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
		label.textColor = .black
		label.numberOfLines = 1
		return label
	}()
	
	// MARK: - label for start date month
	let startDateMonthLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		label.textColor = .black
		label.numberOfLines = 1
		return label
	}()
	
	// MARK: - label for end date
	let endDateLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		label.textColor = UIColor.black
		label.numberOfLines = 1
		return label
	}()
	
	// MARK: - label for title
	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
		label.textColor = UIColor.label
		label.numberOfLines = 0
		return label
	}()
	
	// MARK: - stack view for time
	let timeStackView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.distribution = .fillProportionally
		view.alignment = .center
		view.axis = .horizontal
		view.spacing = 10
		return view
	}()
	
	// MARK: - label for time
	let timeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		label.textColor = UIColor.label
		label.numberOfLines = 1
		return label
	}()
	
	// MARK: - imageview for the time icon
	let timeIcon: UIImageView = {
		let icon = UIImageView()
		icon.image = UIImage(systemName: "clock")
		icon.tintColor = UIColor.label
		icon.contentMode = .scaleAspectFill
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	
	// MARK: - stack view for description
	let descriptionStackView: UIStackView = {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.distribution = .fillProportionally
		view.alignment = .center
		view.axis = .horizontal
		view.spacing = 10
		return view
	}()
	
	// MARK: - label for description
	let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		label.textColor = UIColor.label
		label.numberOfLines = 1
		return label
	}()
	
	// MARK: - imageview for the time icon
	let descriptionIcon: UIImageView = {
		let icon = UIImageView()
		icon.image = UIImage(systemName: "pencil")
		icon.tintColor = UIColor.label
		icon.contentMode = .scaleAspectFill
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	
	func setTestCellTwo() {
		
		// add the card view
		contentView.addSubview(cardView)
		
		// add the stack view inside of the card view
		cardView.addSubview(stackViewInCardView)
		
		// add to stackview inside of card view
		stackViewInCardView.addArrangedSubview(startDateDayLabel)
		stackViewInCardView.addArrangedSubview(startDateMonthLabel)
		stackViewInCardView.addArrangedSubview(endDateLabel)
		
		// add stack view next to card view
		contentView.addSubview(stackView)
		
		// add labels and icons to stack view
		timeStackView.addArrangedSubview(timeIcon)
		timeStackView.addArrangedSubview(timeLabel)
		descriptionStackView.addArrangedSubview(descriptionIcon)
		descriptionStackView.addArrangedSubview(descriptionLabel)
		
		// add views to stack view
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(timeStackView)
		stackView.addArrangedSubview(descriptionStackView)
		
		NSLayoutConstraint.activate([
			
			// constraints for card view
			cardView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
			cardView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
			cardView.widthAnchor.constraint(equalToConstant: 120),
			cardView.heightAnchor.constraint(equalToConstant: 120),
			cardView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			
			// constraints for stack view in card view
			stackViewInCardView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
			stackViewInCardView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
			stackViewInCardView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
			stackViewInCardView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
			
			// constraints for stack view next to card view
			stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
			stackView.leadingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 10),
			stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
			stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			
			// constraints for time icon
			timeIcon.widthAnchor.constraint(equalToConstant: 20),
			timeIcon.heightAnchor.constraint(equalToConstant: 20),
			
			// constraints for description icon
			descriptionIcon.widthAnchor.constraint(equalToConstant: 20),
			descriptionIcon.heightAnchor.constraint(equalToConstant: 20),
		])
		
		// set description label
		descriptionLabel.text = "This is a description"
		
		// set title label
		titleLabel.text = "This is a title"
		
		// set start day label
		startDateDayLabel.text = "20."
		
		// set start month label
		startDateMonthLabel.text = "July"
		
		// set end date label
		endDateLabel.text = "End date"
		
		// set time label
		timeLabel.text = "11:00 - 12:00"
		
		
	}
	
}

//class TabOneNavigationController: UINavigationController {
//
//	// set icons to white
//	override var preferredStatusBarStyle: UIStatusBarStyle {
//		return .lightContent
//	}
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//
//		if #available(iOS 13.0, *) {
//			let navBarAppearance = UINavigationBarAppearance()
//			navBarAppearance.configureWithOpaqueBackground()
//			navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//			navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//			navBarAppearance.backgroundColor = .blue
//			navigationBar.standardAppearance = navBarAppearance
//			navigationBar.scrollEdgeAppearance = navBarAppearance
//		}
//
//	}
//
////	override func viewWillAppear(_ animated: Bool) {
////		print("TONC", #function)
//////		if #available(iOS 13.0, *) {
//////			let navBarAppearance = UINavigationBarAppearance()
//////			navBarAppearance.configureWithOpaqueBackground()
//////			navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//////			navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//////			navBarAppearance.backgroundColor = .blue
//////			navigationBar.standardAppearance = navBarAppearance
//////			navigationBar.scrollEdgeAppearance = navBarAppearance
//////		}
////
////	}
//
//}

class TabOneNavigationController: UINavigationController {
	
	// set icons to white
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		// add this line to fix the layout problem
		super.viewWillAppear(animated)
		
		if #available(iOS 13.0, *) {
			let navBarAppearance = UINavigationBarAppearance()
			navBarAppearance.configureWithOpaqueBackground()
			navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
			navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
			navBarAppearance.backgroundColor = .blue
			navigationBar.standardAppearance = navBarAppearance
			navigationBar.scrollEdgeAppearance = navBarAppearance
		}
		
	}
	
}

class FirstVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let label: UILabel = {
			let v = UILabel()
			v.text = "First TAB"
			v.textAlignment = .center
			v.backgroundColor = .cyan
			v.translatesAutoresizingMaskIntoConstraints = false
			return v
		}()
		view.addSubview(label)
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: g.topAnchor),
			label.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			label.heightAnchor.constraint(equalToConstant: 80.0),
			label.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.5),
		])
	}
}
class SecondVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		let label: UILabel = {
			let v = UILabel()
			v.text = "Second TAB"
			v.textAlignment = .center
			v.backgroundColor = .yellow
			v.translatesAutoresizingMaskIntoConstraints = false
			return v
		}()
		view.addSubview(label)
		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: g.topAnchor),
			label.leadingAnchor.constraint(equalTo: g.leadingAnchor),
			label.heightAnchor.constraint(equalToConstant: 80.0),
			label.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.5),
		])
	}
}

class MyTabBarController: UITabBarController {

	var changingTabs: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//delegate = self
	}

	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		print(#function, selectedIndex, item)
		if let idx = tabBar.items?.firstIndex(of: item) {
			if idx == selectedIndex {
				print("same tab")
				if let vc = self.viewControllers?[selectedIndex] as? HasScrollVC {
					vc.scrollToTop()
				}
			}
		}
	}
	
}
class HasScrollVC: UIViewController {
	func scrollToTop() {
		print(#function)
	}
}

protocol FirstTabDelegate: NSObject {
	func someDelegateFunctionInFirst(_ str: String)
}
protocol SecondTabDelegate: NSObject {
	func someDelegateFunctionInSecond(_ str: String)
}
class MyCustomTabBarController: UITabBarController, UITabBarControllerDelegate {
	
	weak var firstDelegate: FirstTabDelegate?
	weak var secondDelegate: SecondTabDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
		delegate = self
	}

	// this is called *when* the tab item is selected (tapped)
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

		firstDelegate?.someDelegateFunctionInFirst("Delegate item")
		secondDelegate?.someDelegateFunctionInSecond("Delegate item")
		
		guard let theItems = self.tabBar.items,
			  let idx = theItems.firstIndex(of: item),
			  let controllers = self.viewControllers
		else { return }
		
		if let vc = controllers[idx] as? FirstTabVC {
			vc.someFunctionInFirst("From didSelect item")
		}
		if let vc = controllers[idx] as? SecondTabVC {
			vc.someFunctionInSecond("From didSelect item")
		}

	}

	// this is called when the tab's ViewController is selected (*after* the tab item is selected (tapped))
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		
		firstDelegate?.someDelegateFunctionInFirst("Delegate select")
		secondDelegate?.someDelegateFunctionInSecond("Delegate select")
		
		if let vc = viewController as? FirstTabVC {
			vc.someFunctionInFirst("From didSelect viewController")
		}
		if let vc = viewController as? SecondTabVC {
			vc.someFunctionInSecond("From didSelect viewController")
		}
	}
	
}

class FirstTabVC: UIViewController, FirstTabDelegate {
	override func viewDidLoad() {
		super.viewDidLoad()
		if let tbc = self.tabBarController as? MyCustomTabBarController {
			tbc.firstDelegate = self
		}
	}
	public func someFunctionInFirst(_ str: String) {
		print("In First Tab VC: ", str)
	}
	func someDelegateFunctionInFirst(_ str: String) {
		print("In First Tab VC delegate: ", str)
	}
}
class SecondTabVC: UIViewController, SecondTabDelegate {
	override func viewDidLoad() {
		super.viewDidLoad()
		if let tbc = self.tabBarController as? MyCustomTabBarController {
			tbc.secondDelegate = self
		}
	}
	public func someFunctionInSecond(_ str: String) {
		print("In Second Tab VC: ", str)
	}
	func someDelegateFunctionInSecond(_ str: String) {
		print("In Second Tab VC delegate: ", str)
	}
}
