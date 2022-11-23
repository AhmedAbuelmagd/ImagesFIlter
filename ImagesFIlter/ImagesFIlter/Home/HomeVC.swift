//
//  HomeVC.swift
//  ImagesFIlter
//
//  Created by Ahmed Abuelmagd on 23/11/2022.
//

import UIKit
import Combine

class HomeVC: UIViewController {

    @IBOutlet weak var chooseImageBtn: UIButton!
    @IBOutlet weak var filtersCV: UICollectionView!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var orignalImage: UIImage = UIImage(named: "baby")!
    private let viewModel = FiltersViewModel()
    private var anyCancellable = Set<AnyCancellable>()
    private var localTasks: [FilterModel]?
    var editingImage: UIImage!
    var centerVector: CIVector!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    @IBAction func chooseImageBtnClicked(_ sender: UIButton) {
        actionSheet()
    }
    
    @IBAction func saveImgBtnClicked(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(mainImg.image!, nil, nil, nil)
        let alert = UIAlertController(title: "Success", message: "Your Image saved to photo library successfully.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension HomeVC{
    func initUI(){
        mainImg.addBorder(borderColor: .MainColor, borderWidth: 3)
        mainImg.addRadius(radius: 10)
        for item in [chooseImageBtn, saveBtn]{
            item?.addRadius(radius: 5)
        }
        chooseImageBtn.addBorder()
        initCV(cv: filtersCV)
        bindToViewModel()
        Task { await viewModel.getFilters() }
    }
    func actionSheet(){
        let alert = UIAlertController(title: "Upload File", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default , handler:{ (UIAlertAction)in
            self.upload(isCamera: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default , handler:{ (UIAlertAction)in
            self.upload()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func upload(isCamera:Bool = false){
        if isCamera{ AttachmentHandler.shared.openCamera(vc: self)
        }else{ AttachmentHandler.shared.openGallery(vc: self) }
        AttachmentHandler.shared.imagePickedBlock = { [weak self] (image) in
            guard let self = self else { return }
            self.mainImg.image = image
            self.editingImage = image
            self.orignalImage = image
            self.filtersCV.reloadData()
//            self.saveImagesFromVdeo(path:videoPath)
        }
    }
    func initCV(cv: UICollectionView){
        cv.delegate = self
        cv.dataSource = self
        cv.registerCVNib(cell: FilterCVCell.self)
    }
    private func bindToViewModel () {
        viewModel.$tasks
            .receive(on: DispatchQueue.main)
            .sink { [ weak self] tasks in
                guard let self = self else { return }
                self.localTasks = tasks
                self.filtersCV.reloadData()
            }.store(in: &anyCancellable)
    }
}
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localTasks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCV(index: indexPath) as FilterCVCell
        if let cellData = localTasks?[indexPath.row]{
            cell.initCell(cellData: cellData, orignalImage: orignalImage)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0..<(localTasks?.count ?? 0){
            localTasks?[index].isSelected = false
        }
        localTasks?[indexPath.row].isSelected = true
        filtersCV.reloadData()
        
        let openGLContext = EAGLContext(api: .openGLES2)
        let context = CIContext(eaglContext: openGLContext!)
        let filter = CIFilter(name: localTasks?[indexPath.row].name ?? "")
        let coreImage = CIImage(image: orignalImage)
        filter!.setDefaults()
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        let filteredImageRef = context.createCGImage(filteredImageData, from: filteredImageData.extent)
        let imageForButton = UIImage(cgImage: filteredImageRef!)
        mainQueue {
            self.mainImg.image = imageForButton
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cVHeight = collectionView.bounds.height
        return CGSize(width: cVHeight*0.8, height: cVHeight)
    }
}
