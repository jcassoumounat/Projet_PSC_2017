N=255;
t=(1:N)/10;

sinus = sin(t);
figure; plot(sinus);

bruitblanc=SignalAWGN(sinus,0.1);
figure; plot(bruitblanc);

diaphonie=SignalCrossTalk(sinus);
figure; plot(diaphonie);

degat=SignalDamaged(sinus);
figure;plot(degat);