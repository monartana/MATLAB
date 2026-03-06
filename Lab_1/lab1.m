% Очищення середовища
clear, close all;

% Зчитування вбудованих зображень різних форматів
I1 = imread('coins.png'); 
I2 = imread('rice.png');  
I3 = imread('trees.tif');

% Відображення
imshow(I1); title('Coins (PNG)'); 
figure, imshow(I2); title('Rice (PNG)');
figure, imshow(I3); title('Trees (TIFF)');

% Завантаження зображення з каталогу
f = imread('pictures/pic_1.png');

% Отримання інформації про зображення
img_size = size(f);
whos f;           

% Збереження зображення у заданий каталог
imwrite(f, 'results/new_pic_1.png');

% Перетворюємо кольорове зображення в напівтонове для аналізу яскравості
f_gray = rgb2gray(f); 

% Виводимо зображення та гістограму
figure;
subplot(1,2,1); imshow(f_gray); title('Напівтонове зображення');
subplot(1,2,2); imhist(f_gray); title('Гістограма яскравостей');

% Виконуємо контрастування напівтонового зображення
f_adj = imadjust(f_gray);

% Виводимо результат та нову гістограму
figure;
subplot(1,2,1); imshow(f_adj); title('Контрастоване зображення');
subplot(1,2,2); imhist(f_adj); title('Гістограма після обробки');

% Отримання негатива
% Параметри [0,1] та [1,0] міняють місцями мінімальну та максимальну яскравість
f_neg = imadjust(f_gray, [0, 1], [1, 0]);

% Відображення результату
figure;
subplot(1,2,1); imshow(f_gray); title('Оригінал (сірий)');
subplot(1,2,2); imshow(f_neg); title('Негатив зображення');

% Виклик довідки
% Отримання стислої довідки в командному вікні
help imadjust

% Отримання розширеної документації в окремому вікні
doc imadjust