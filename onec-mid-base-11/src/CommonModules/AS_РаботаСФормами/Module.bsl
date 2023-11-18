
//+AS,20230821, добавление реквизитов на форму 
#Область ПрограммныйИнтерфейс
//Процедура дополняет форму реквизитами
Процедура ДополнитьФорму(Форма) Экспорт
	
	//ИмяФормы = Форма.ИмяФормы;
	
	Если Форма.ИмяФормы = "Документ.ЗаказПокупателя.Форма.ФормаДокумента" Тогда
		ДобавитьРеквизитыНаФорму("AS_КонтактноеЛицо","Контактное Лицо",Форма.Элементы.ГруппаШапкаПраво,"ПолеФормы",,,Форма);
		ДобавитьРеквизитыНаФорму("ГруппаСкидка",Неопределено,Форма.Элементы.ГруппаШапкаЛево,"ГруппаФормы",,,Форма);
		Реквизит_СогласованнаяСкидка = ДобавитьРеквизитыНаФорму("AS_СогласованнаяСкидка","Согласованная Скидка",
		Форма.Элементы.ГруппаСкидка,"ПолеФормы",,,Форма);   
		Реквизит_СогласованнаяСкидка.УстановитьДействие("ПриИзменении","AS_ЗадатьВопрос");
		ДобавитьРеквизитыНаФорму("AS_СогласованнаяСкидка","Согласованная Скидка",
		Форма.Элементы.ГруппаСкидка,"КнопкаФормы","Пересчитать","AS_Пересчитать",Форма);	
	ИначеЕсли Форма.ИмяФормы = "Документ.ПоступлениеТоваровУслуг.Форма.ФормаДокумента" Тогда
		ДобавитьРеквизитыНаФорму("AS_КонтактноеЛицо","Контактное Лицо",Форма.Элементы.ГруппаШапкаПраво,"ПолеФормы",,,Форма);	
	ИначеЕсли Форма.ИмяФормы = "Документ.РеализацияТоваровУслуг.Форма.ФормаДокумента" Тогда     
		ДобавитьРеквизитыНаФорму("AS_КонтактноеЛицо","Контактное Лицо",Форма.Элементы.ГруппаШапкаПраво,"ПолеФормы",,,Форма);	
	ИначеЕсли Форма.ИмяФормы = "Документ.ОплатаОтПокупателя.Форма.ФормаДокумента" Тогда 
		ВставитьРеквизитыНаФорму(Форма,"AS_КонтактноеЛицо","Основание","Контактное Лицо");	
	ИначеЕсли Форма.ИмяФормы = "Документ.ОплатаПоставщику.Форма.ФормаДокумента" Тогда    
		ВставитьРеквизитыНаФорму(Форма,"AS_КонтактноеЛицо","СуммаДокумента","Контактное Лицо");		
	КонецЕсли;	
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
Процедура ВставитьРеквизитыНаФорму(Форма,Название,СледующийЭлемент,ЗаголовокПоля)
	
	ПолеВвода = Форма.Элементы.Вставить(
	Название,  
	Тип("ПолеФормы"),,Форма.Элементы[СледующийЭлемент]);	     
	ПолеВвода.Заголовок = ЗаголовокПоля;
	ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
	ПолеВвода.ПутьКДанным = "Объект." + Название;
	
КонецПроцедуры
 
Функция ДобавитьРеквизитыНаФорму(Название,ЗаголовокРекв = Неопределено,РодительРекв,ТипЭлемента,ЗаголовокКоманды = Неопределено,ПроцедураФормы = Неопределено,Форма)
	
	Если ТипЭлемента = "ПолеФормы" Тогда
		ПолеВвода = Форма.Элементы.Добавить(
		Название,    
		Тип(ТипЭлемента), 
		РодительРекв);	      
		ПолеВвода.Заголовок = ЗаголовокРекв;
		ПолеВвода.Вид = ВидПоляФормы.ПолеВвода;
		ПутьФормы = "Объект." + Название;
		ПолеВвода.ПутьКДанным = ПутьФормы; 
		Возврат ПолеВвода;
	ИначеЕсли ТипЭлемента = "ГруппаФормы" Тогда
		ГруппаСкидка = Форма.Элементы.Добавить(Название, Тип(ТипЭлемента),РодительРекв);
		ГруппаСкидка.Вид = ВидГруппыФормы.ОбычнаяГруппа;
		ГруппаСкидка.Заголовок = "";
		ГруппаСкидка.ОтображатьЗаголовок = Ложь;
		ГруппаСкидка.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда; 
		Возврат ГруппаСкидка;
	ИначеЕсли ТипЭлемента = "КнопкаФормы" Тогда
		КнопкаФормы = Форма.Команды.Добавить(ПроцедураФормы);
		КнопкаФормы.Заголовок = ЗаголовокКоманды;
		КнопкаФормы.Действие = ПроцедураФормы; 
		КнопкаНаФорме = Форма.Элементы.Добавить(ПроцедураФормы,Тип(ТипЭлемента),РодительРекв);
		КнопкаНаФорме.ИмяКоманды = ПроцедураФормы;  
		КнопкаНаФорме.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
		Возврат КнопкаФормы;	
	КонецЕсли;   
	
КонецФункции        
#КонецОбласти
//- AS,20230821, добавление реквизитов на форму


