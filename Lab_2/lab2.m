% Зчитуємо стандартні зображення з бібліотеки MATLAB
I1 = imread('eight.tif'); 
I2 = imread('cameraman.tif');
I3 = imread('coins.png');

% Відображення завантажених зображень
figure, imshow(I1); title('Зображення 1');
figure, imshow(I2); title('Зображення 2');
figure, imshow(I3); title('Зображення 3');

% Додавання гаусівського шуму (середнє 0, дисперсія 0,01 за замовчуванням)
J1_gauss = imnoise(I1, 'gaussian');

% Додавання імпульсного шуму з щільністю 0,05 (5% пікселів)
J1_salt = imnoise(I1, 'salt & pepper', 0.05);

% Додавання імпульсного шуму з вищою щільністю 0,1
J2_salt = imnoise(I2, 'salt & pepper', 0.1);

% Відображення результатів зашумлення
figure, imshow(J1_gauss); title('Гаусівський шум (I1)');
figure, imshow(J1_salt); title('Імпульсний шум 0,05 (I1)');
figure, imshow(J2_salt); title('Імпульсний шум 0,1 (I2)');

% Визначення низькочастотної маски (усереднювальна 3х3)
h_low = ones(3,3) / 9; 

% Визначення високочастотної маски (підкреслення контурів)
h_high = [0 -1 0; -1 5 -1; 0 -1 0];

% Фільтрація вихідного зображення I1
I1_low = imfilter(I1, h_low);
I1_high = imfilter(I1, h_high);

% Відображуємо результат фільтрації
figure, imshow(I1_low); title('Низькочастотна фільтрація (згладжування)');
figure, imshow(I1_high); title('Високочастотна фільтрація (різкість)');

% Фільтрація гаусівського шуму низькочастотним фільтром
J1_gauss_filtered = imfilter(J1_gauss, h_low);

% Спроба фільтрації імпульсного шуму лінійним фільтром
J1_salt_filtered = imfilter(J1_salt, h_low);

% Відображуємо результат
figure, imshow(J1_gauss_filtered); title('Лінійна фільтрація (Гаус)');
figure, imshow(J1_salt_filtered); title('Лінійна фільтрація (Імпульсний)');

% Адаптивна фільтрація зашумленого зображення
K_gaus = wiener2(J1_gauss, [5 5]);

% Відображення результату
figure, imshow(K_gaus); title('Адаптивна вінерівська фільтрація');


% Медіанна фільтрація імпульсного шуму
K_med_salt = medfilt2(J1_salt);

% Медіанна фільтрація гаусівського шуму для порівняння
K_med_gauss = medfilt2(J1_gauss);

% Відображення результатів
figure, imshow(K_med_salt); title('Медіанна фільтрація (Імпульсний шум)');
figure, imshow(K_med_gauss); title('Медіанна фільтрація (Гаусівський шум)');