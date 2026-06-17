% Зчитування та відображення оригіналу
I = imread('cameraman.tif');
figure, imshow(I); title('Вихідне зображення');

% Змазання: зсув на 21 піксель під кутом 0 градусів
LEN = 21;
THETA = 0;
PSF = fspecial('motion', LEN, THETA);

% Формування змазаного зображення
blurred = imfilter(I, PSF, 'conv', 'circular');
figure, imshow(blurred); title('Змазане зображення');

% Відновлення за відсутності шумів
wnr1 = deconvwnr(blurred, PSF, 0);
figure, imshow(wnr1); title('Відновлене зображення (без шуму)');

% Додавання шуму до змазаного зображення
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);

% Відновлення з врахуванням SNR
estimated_nsr = noise_var / var(im2double(I(:)));
wnr2 = deconvwnr(blurred_noisy, PSF, estimated_nsr);

figure, imshow(blurred_noisy); title('Змазане зашумлене зображення');
figure, imshow(wnr2); title('Відновлення зашумленого зображення');