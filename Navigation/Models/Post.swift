//
//  Post.swift
//  Navigation
//
//  Created by Timur on 10.04.2022.
//

import Foundation

struct Post {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
    
    static func makeMockModel() -> [Post] {
        var model = [Post]()
        model.append(Post(author: "Life.ru", description: "Германия же требует, чтобы Италия гарантировала прекращение действия судебных решений, посягающих на её права, и полностью возместила ущерб. В частности, страна в своём запросе просит гарантий, что немецкая собственность, отмеченная в заявлении, не будет выставлена на открытом аукционе до вынесения судом решения. Ранее Лайф писал, что суд признал геноцидом преступления нацистов в годы ВОВ на территории Ростовской области. По данным прокуратуры, в общей сложности за время оккупации на территории региона было уничтожено, а также отправлено в концлагеря и на принудительные работы более 200 тысяч советских граждан.", image: "avatar", likes: 234, views: 588))
        model.append(Post(author: "РИА Новости", description: "«Мы не позволим себя шантажировать! Мы и впредь не будем платить за российский газ в рублях. Ясно одно: мы делаем все возможное, чтобы как можно быстрее стать независимыми от России», — подчеркнул Линднер. После начала спецоперации по демилитаризации и денацификации Украины Запад усилил санкционное давление на Москву. Многие страны объявили о заморозке российских активов, стали громче звучать призывы отказаться от энергоносителей. США ввели 8 марта запрет на импорт российской нефти, некоторых нефтепродуктов, СПГ и угля. Следом Великобритания объявила, что к концу 2022 года прекратит закупать нефть и нефтепродукты.", image: "avatar2", likes: 332, views: 522))
        model.append(Post(author: "Известия", description: "Новая выплата для малообеспеченных семей начнет действовать в России с 1 мая: ее смогут получить родители с детьми в возрасте от 8 до 17 лет. Таким образом, в России появится так называемая бесшовная система поддержки, охватывающая малообеспеченные семьи с детьми в возрасте от 3 до 17 лет. Кроме того, с начала месяца в некоторых школах перед началом недели будет звучать Гимн России, а бывшим членам летных экипажей и шахтерам увеличат пенсии. Подробнее об этих и других нововведениях — в традиционном обзоре «Известий».", image: "avatar3", likes: 352, views: 463))
        model.append(Post(author: "Ведомости", description: "«Роскосмос» принял решение по дате окончания работы России на Международной космической станции (МКС), однако сообщать о нем публично госкорпорация не будет, сообщил генеральный директор «Роскосмоса» Дмитрий Рогозин.", image: "avatar", likes: 455, views: 584))
        return model
    }
}
