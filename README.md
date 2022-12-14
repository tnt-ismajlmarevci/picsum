# Picsum project

This project is written in Swift and uses Xcode as the development environment. The project's goal is to consume a public API https://picsum.photos/ making an app that shows auto reload an infinite list of images with a good collection view layout. Also opening specific image page while tapping on of images. //.

Getting Started

To get started with this project, you will need to have Xcode installed on your machine. You can download Xcode from the Mac App Store.

Once you have Xcode installed, you can clone this repository to your local machine using a Git client, such as the one built into Xcode. Alternatively, you can download a zip file of the repository and unzip it to a local directory.

#Project Structure
The project is organized as follows:

├── AppDelegate.swift
├── SceneDelegate.swift
├── Assets.xcassets
├── Info.plist
├── REST
├───── RequestREST.plist
├───── ServiceREST.plist
├───── ResponseREST.plist
├───── Pagination.plist
├── Tab
├───── TabBar.lproj
├───── Picsum
├───────── Picsum.lproj
├───────── Controllers
├───────────── PicsumController.swift
├───────────── PicsumDetailsController.swift
├───────── Views
├───────────── ImageCCell
├───────────────── ImageCCell.swift
├───────────────── ImageCCell.xib
├───────────── HeaderRView
├───────────────── HeaderRView.swift
├───────────────── HeaderRView.xib
├───────── ViewModel
├───────────── PicsumViewModel.swift
├───────── Models
├───────────── Image.swift
├───────── Rest
├───────────── PicsumREST.swift
├───── Search
├───────── Search.lproj
├───────── Controllers
├───────────── SearchController.swift
├───── Profile
├───────── Profile.lproj
├───────── Controllers
├───────────── ProfileController.swift
├── Utlities
├───── CustomSlider.swift
└───── UIViewExtensions.swift

#Third-party Libraries
The project has third-party libraries as follows:
- Kingfisher - a powerful, pure-Swift library for downloading and caching images from the web.
- Alamofire - an HTTP networking library written in Swift.
- SwiftyJSON - easy to deal with JSON data in Swift.
- UIScrollView+InfiniteScroll - Infinite scroll implementation as a category for UIScrollView.




