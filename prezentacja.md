---
title: "Currency project"
output: html_document

# Motywacja  

</br>

Projekt ma na celu pobranie, przetworzenie oraz zaprezentowanie danych dotyczącyh wartości walut na przełomie lat.
  
Przedstawione za jego pomocą informacje mają na celu zilustrowanie wahania poszczególnych kursów, różnice w ich wartości w obecnym czasie jak i na przełomie lat oraz program ma wskazywać na nagłe skoki cen.

Cały program napisany bedzie w języku R a do stworzenia samej aplikacji okienkowej wykorzystany zostanie pakiet "shiny".


</br>

# Opis danych

Dane, które zostaną pobrane oraz uzyte pochodzic bedą ze strony Narodowego Banku Polskiego, który udostępnia API, służące do pobierania tak samo bieżącyh jak i archiwalnych informacji w formacie JSON lub XML. Na potrzeby naszego projektu wykorzystany bedzie format JSON.  
  
Komunikacją z API odbywać się będzie za pomoca ścieżek do konkretnych danych:  
  
<span style="color:blue">http://api.nbp.pl/api/exchangerates/rates/{table}/{code}/{startDate}/{endDate}/</span>  
  
parametry:  
{table} - określa z jakiej tabeli chcemy otrzymać informacje, jako ze dane są podzielone na waluty wymienialne oraz niewymienialne.  
{code} - określa kod waluty, której chcemy sie przyjżeć.  
{startDate} - początek przedziału okresu, z któRego chcemy miec informajce.  
{endDate} - koniec okresu.  
  
Wywołując takie zapytanie pomijając parametr {code} otrzymujemy plik mówiący nam o wartości wszystkich danych z wybranej tabeli na przełomie zdefiniowanego okresu, gdzie kazdy record jest podpisany wartością, kodem, nazwą waluty oraz datą pomiaru:  
  
http://api.nbp.pl/api/exchangerates/tables/a/2012-01-01/2012-01-31/  

![alt text](https://github.com/z4a33/Currency_proejct/blob/master/images/date_cur.png?raw=true)

# Planowane funkcjonalności aplikacji

1. Przedstawienie wykresu wahań danej waluty ze wzgledu na zakres czasu.
2. Porównanie wartości kilku walut w obrębie danego czasu.
3. Przeliczanie walut (kalkulator walut).
4. Przedstawienie na wykresie słupkowym porównania aktualnych cen (wybranych walut).
5. Sprawdzenie, czy waluta spada gwałtownie.

Aplikacja zakłada również dowolność w zmienianiu zakresu czasu oraz w zmienianiu walut, którym chcemy się przyjrzeć.
