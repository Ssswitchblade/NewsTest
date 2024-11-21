//
//  BaseUIImageView.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 17.11.2024.
//

import UIKit

class BaseUIImageView: UIImageView {
    private static let imageCache = NSCache<NSURL, UIImage>()
       private var currentURL: NSURL?

       /// Загружает изображение по указанному URL с поддержкой кэширования.
       /// - Parameters:
       ///   - urlString: URL-строка изображения.
       ///   - placeholder: Изображение-заполнитель, показываемое до загрузки.
       func loadImage(from urlString: String, placeholder: UIImage? = nil) {
           guard let url = URL(string: urlString) else {
               print("Неверный URL: \(urlString)")
               return
           }

           currentURL = url as NSURL

           if let cachedImage = BaseUIImageView.imageCache.object(forKey: url as NSURL) {
               image = cachedImage
               return
           }

           image = placeholder

           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
               if let error = error {
                   print("Ошибка загрузки изображения: \(error.localizedDescription)")
                   return
               }

               guard let data = data, let downloadedImage = UIImage(data: data) else {
                   print("Ошибка: нет данных или данные не являются изображением.")
                   return
               }

               BaseUIImageView.imageCache.setObject(downloadedImage, forKey: url as NSURL)

               DispatchQueue.main.async {
                   if self?.currentURL == url as NSURL {
                       self?.image = downloadedImage
                   }
               }
           }.resume()
       }
}
