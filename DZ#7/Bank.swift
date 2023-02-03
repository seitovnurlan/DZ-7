//
//  Bank.swift
//  DZ#7
//
//  Created by Nurlan Seitov on 3/2/23.
//

import Foundation

class Bank {
    var bankName: String
    var clients: [Client]
    
    init(bankName: String, clients: [Client]) {
        self.bankName = bankName
        self.clients = clients
    }
    
    
    func moneyTransfer() {
        //Просим ввести карту от кого отправить средства
        print("Выбери карту по ее номеру:")
        let cardNumberInput = readLine()!
        
        //Вызываем созданный нами метод findClient, который
        // принимает в себя номер карты типа String, делает поиск циклом по массиву из клиентов и у клиента по массиву из карточек, и, если находит необходимого клиента по карте, возвращает этого найденного клиента, если нет, возвращает nil
        var fromClient: Client? = findClient(by: cardNumberInput)
        
        //Через guard проверяем, что клиент не равен nil. А если же равен, просим заново ввести номер карты, вызывая метод moneyTransfer()
        guard fromClient != nil else {
            print("Не найден такой клиент! Попробуйте заново ввести!")
            moneyTransfer()
            return
        }
        
        //Находим карту клиента, который отправляет средства.
        let fromClientCard = findClientsCard(of: fromClient!)
        //Выводим в консоль имя банка, которое содержится в банковской карте клиента
        print(fromClientCard.bankName)
        
        
        //Запрашиваем ввести номер счета(карты) клиента, которому
        // необходимо отправить средства
        print("введите номер счета кому отправить деньги")
        var toClientInputСardNumber = readLine()!
        //По аналогии с 1м клиентом, пытаемся найти клиента
        var toClient: Client? = findClient(by: toClientInputСardNumber)
        
        //Через бесконечный цикл, проверяем, если клиент не найден, просим ввести заново номер карты для клиента, которому нужно отправить данные, и повторно ищем его.
        //Если же найден, выходим из бесконечного цикла
        while true {
            if toClient == nil {
                print("Не найден клиент для отправки средств! Попробуйте заново ввести!")
                toClientInputСardNumber = readLine()!
                toClient = findClient(by: toClientInputСardNumber)
            } else {
                break
            }
        }
        //        guard toClient != nil else {
        //            print("Не найден клиент для отправки средств! Попробуйте заново ввести!")
        //            moneyTransfer()
        //            return
        //        }
        
        //Если клиент найдент, выводим его ФИО в консоль
        print(toClient!.firstName, toClient!.lastName)
        
        //Просим пользователя ввести кол-во средств, которое необходимо отправить
        print("введите сумму перевода (числом)!")
        
        
//        var billInput = Int(readLine()!) ?? 0
        
        var billInput = Int(readLine()!)
        
        //через бесконечный цикл проверки на nil, проверяем, что если в ридлайн
        //введено не число, выводить в консоль соответсвующее предупреждение,
        //и повторно вызывать ридлайн
        
        //если же введено число (наш Int ридлайн не равен nil), покидаем
        //бесконечный цикл с помощью ключевого слова break
        while true {
            if billInput == nil {
                print("введите сумму числом!")
                billInput = Int(readLine()!)
            } else {
                break
            }
        }
        
        //Находим карту клиента, которому необходимо отправить средства
        let toClientCard = findClientsCard(of: toClient!)
        
        //Делаем проверку, если у карты клиента bill (счет) больше или равен
        //количеству средств, которое мы хотим отправить:
        //клиенту на карту, которому мы собираемся отправить средства
        //прибавляем billInput
        // и, в то же время, отнимаем у клиента, который отправляет
        // со счета bill количество средств billInput
        //выводим в консоль сообщение об успешной операции
        //и информацию об обоих клиентах
        
        
        //если же количество средств на карте клиента, который отправляет слишком маленькое, выводим в консоль соответствующее предупреждение
        if fromClientCard.bill >= billInput! {
            toClientCard.bill += billInput!
            fromClientCard.bill -= billInput!
            print("информация о пользователях операции:")
            fromClient!.showInfo()
            toClient!.showInfo()
        } else {
            print("Недостаточно средств! У вас \(fromClientCard.bill) KGS, хотите отправить \(billInput!). Пополните баланс!")
        }
        
    }
    
    //Метод принимает параметр cardNumber типа String и возвращает опционального Client
    private func findClient(by cardNumber: String) -> Client? {
        //Создаем переменную, isFound (рус. "Найден ли") типа Bool
        var isFound: Bool = false
        //Создаем дефолтного клиента (пустышку)
        var foundClient = Client(firstName: "", lastName: "", cards: [])
        
        //Проходимся циклом по всем клиентам банка поочередно
        for client in clients {
            //Проходимся циклом по карте каждого клиента
            for card in client.cards {
                //И если номер карты у клиента из массива клиентов Банка равен
                //номеру карты, который мы вводили в консоль
                if card.cardNumber == cardNumber {
                    //наш дефолтный клиент превращается в этого клиента
                    foundClient = client
                    //и isFound устанавливаем true
                    isFound = true
                    //выходим из цикла через ключ. слово break
                    break
                }
            }
        }
        
        //если найден клиент (проверяем через переменную isFound)
        if isFound == true {
            //возвращаем его
            return foundClient
        } else {
            //если не найден – возвращаем nil
            return nil
        }
    }
    
    
    //Метод, принимающий в себя 1 параметр clientsToFindCard типа Client
    // и возвращающий тип данных Card
    private func findClientsCard(of clientsToFindCard: Client) -> Card {
        //Создаем переменную, isFound (рус. "Найден ли") типа Bool
        var isFound: Bool = false
        //Создаем пустышку типа данных card
        var card = Card(bankName: "", cardNumber: "", bill: 0)
        
        //Проходимся циклом по всем клиентам банка поочередно
        for client in clients {
            //Проходимся циклом по карте каждого клиента через enumerated()
            
            //Почему именно так? Потому что у клиента, которого карту нужно найти и у клиента банка есть массив из карточек
            //в этих массивах мы можем брать каждую карточку поочередно, через индекс
            for (id, _) in client.cards.enumerated() {
                //сравниваем, если номер карточки клиента из массива Банка равен
                //номеру карточки клиенту, по которому мы ищем эту карточкцу
                if client.cards[id].cardNumber == clientsToFindCard.cards[id].cardNumber {
                    //наша пустышка становится этой самой карточкой
                    card = client.cards[id]
                    //и isFound устанавливаем true
                    isFound = true
                    //выходим из цикла через ключ. слово break
                    break
                }
            }
        }
        //возвращаем эту карточку
        return card
    }
    
    
}
