

import Foundation


// Class
// Protocol
// Talks To -> Interactor, Router, View
// Interactor needs to tell what kind of interaction happened so presenter needs to update the view

//Verileri görünüm tarafına iletme
//View ve Interactor arasındaki bağlantıyı gerçekleştirir
enum NetworkError : Error {
    case networkFailed
    case parsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? { get set }
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
}

class CryptoPresenter : AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCrypto() //interactor ve presenter birbirine bağlandığında bu atanacak
        }
    }
    
    var view: AnyView?
    
    /*
    init(){
        interactor?.downloadCrypto()
    }
     */
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
            case .success(let cryptos):
                view?.update(with: cryptos) //başarılı ise cryptoları göster
            case .failure(_):
                view?.update(with: "Try again later")
        }
    }
    
}
