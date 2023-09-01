ИДЗ4 Вариант 8 Рахильский Марк БПИ218
Работа на 5 баллов

#Условие задачи: 
Анчуария и Тарантерия – два крохотных латиноамериканских государства, затерянных в южных Андах.
Диктатор Анчуарии, дон Федерико, объявил войну диктатору Тарантерии, дону Эрнандо. У обоих диктаторов очень мало
солдат, но очень много снарядов для минометов, привезенных с последней американской гуманитарной помощью. Поэтому
армии обеих сторон просто обстреливают наугад территорию противника, надеясь поразить что-нибудь ценное. Стрельба
ведется по очереди до тех пор, пока либо не будут уничтожены все цели, либо стоимость потраченных снарядов не
превысит суммарную стоимость всего того, что ими можно уничтожить. Создать многопоточное приложение, моделирующее
военные действия.


#Реализация:
Страны представлены в виде матриц 8x8. Координаты клетки генерируются рандомно и уничножают
 клетку противника. Каждый выстрел имеет  цену, а с каждым выстрелом уменьшается бюджет страны.
Страны стреляют по очереди, пока у кого-то не закончатся деньги или
какая-то страна не будет уничтожена.
Запрашивается следующая информация: количество денег у Анчуарии и Тарантерии, стоимость одного выстрела и далее
до конца войны - кол-во выстрелов каждой из стран.

###C++ Code
```C++
#include <iostream>
#include <random>
#include <ctime>
#include <thread>


int anch_money;
int taran_money;
int anch_hits;
int taran_hits;
int cost_shot;
int anch[8][8] = {0};
int taran[8][8] = {0};
int num = 0;

pthread_mutex_t mutex;




/// IS it Nuked?
/// \param name - country
/// \return
bool isEmpty(int name[8][8]) {
    bool isIt = false;
    for (int i = 0; i < 8; ++i) {
        for (int j = 0; j < 8; ++j) {
            if(name[i][j] == 0) {
                isIt = true;
            }
        }
    }
    return isIt;
}

/// Random for shots.
/// \return
int rndNum() {
    srand(time(NULL)+num);
    int x = rand();
    return x;
}



/// Anchuaria spends money.
/// \param param
/// \return
void *makeShotAncuaria(void *param) {
    anch_money -= anch_hits * cost_shot;
    std::cout << "anch made shot: ";
    num++;
    int x = rndNum() % 8;
    num++;
    int y = rndNum() % 8;
    // mutex for value
    pthread_mutex_lock(&mutex);
    taran[x][y] = 1;
    pthread_mutex_unlock(&mutex);
    //output shotted cell
    std::cout << x << " " << y << "\n";
    std::cout << "Block shotted\n";
    //sem_post(&semaphore);
    return nullptr;
}
/// Taran spends money
/// \param param
/// \return
void *makeShottaran(void *param) {
    taran_money -= taran_hits * cost_shot;
    std::cout << "taran shoot: ";
    num++;
    int x = rndNum() % 8;
    num++;
    int y = rndNum() % 8;
    pthread_mutex_lock(&mutex);
    anch[x][y] = 1;
    pthread_mutex_unlock(&mutex);
    //output shotted cell
    std::cout << x << " " << y << "\n";
    std::cout << "Block shotted\n";
    return nullptr;
}


int main() {

    //Amaount for each country
    std::cout << "Enter amount  for each country$$$$$:\n";
    std::cin >> anch_money >> taran_money;
    std::cout << "Enter cost for one bullet:\n";
    std::cin >> cost_shot;
    std::cout << "Anch and Taran countries are fields 8x8. shoots are full randomly\n";

    while ((taran_money >= 0 || anch_money >= 0) && isEmpty(anch) && isEmpty(taran)) {
        std::cout << "Enter number of shots for first and for second country:\n";
        //Frst country
        std::cin >> anch_hits >> taran_hits;
        num = 0;
        //threads
        pthread_t threads_anch[anch_hits];
        pthread_t threads_taran[taran_hits];
        //Anch shots threads
        for (int i = 0; i < anch_hits; i++) {
            num++;
            pthread_create(&threads_anch[i], nullptr, makeShotAncuaria, &i);
            std::this_thread::sleep_for(std::chrono::milliseconds(500));
        }
        // Taran shots threads
        for (int i = 0; i < taran_hits; i++) {
            num++;
            pthread_create(&threads_taran[i], nullptr, makeShottaran, &i);
            std::this_thread::sleep_for(std::chrono::milliseconds(500));
        }
        //Waiting for Anch
        for (int j = 0; j < anch_hits; j++) {
            num++;
            pthread_join(threads_anch[j], nullptr);
        }
        // Waiting for Taran
        for (int j = 0; j < taran_hits; j++) {
            num++;
            pthread_join(threads_taran[j], nullptr);
        }
    }
    //The end statistic
    if (taran_money <= 0) std::cout << "Taran lost all money\n";
    if (anch_money <= 0) std::cout << "Anchuria lost all money\n";
    if (!isEmpty(anch)) std::cout << "Anchuria is Nuked!!! Game over\n";
    if (!isEmpty(taran)) std::cout << "taran is Nuked!!! Game over\n";
    return 0;

}
```

### Параллелизм
На каждом ходе создается кол-во потоков, равное числу выстрелов Анчуарии. Каждый поток генерит клетку для
выстрела и выводит соответсвующую информацию.
Если все выстрелы сделаны, синхроним потоки.
Аналогично для Тарантерии.

В потоки передаются функции (см код)
В программе использован мьютекс и замедление потоков. Пояснения написаны в комментариях
Так же использовался Random, который юзается в разных потоках.
 

###TESTS


Enter amount  for each country$$$$$:
80 80
Enter cost for one bullet:
10
Anch and Taran countries are fields 8x8. shoots are full randomly
Enter number of shots for first and for second country:
8
8
anch made shot: 7 2
Block shotted
anch made shot: 4 0
Block shotted
anch made shot: 6 1
Block shotted
anch made shot: 3 6
Block shotted
anch made shot: 5 0
Block shotted
anch made shot: 2 5
Block shotted
anch made shot: 4 7
Block shotted
anch made shot: 1 4
Block shotted
taran shoot: 3 6
Block shotted
taran shoot: 0 3
Block shotted
taran shoot: 1 5
Block shotted
taran shoot: 7 2
Block shotted
taran shoot: 0 4
Block shotted
taran shoot: 5 1
Block shotted
taran shoot: 7 2
Block shotted
taran shoot: 4 0
Block shotted
Taran lost all money
Anchuria lost all money

Process finished with exit code 0










