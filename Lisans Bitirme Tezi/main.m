clear
yolcu = [];
olasilik_matris = [0 0 0 0 0 0 0.6 0.8 0.8 0.4 0.2 0.3 0.5 0.4 0.2 0.3 0.3 0.8 0.8 0.5 0.2 0 0 0 0]; % her saatin olasiligi

for i=1:50
    otobus=find(round(rand(102,1)));
    for j=1:size(otobus)
        otobus(j)=350+(otobus(j)*10);
        otobusler(i,j)=otobus(j);
    end
end
otobusler=otobusler';

for i = 1 : max(otobusler(i)) %yolcu sayısının otobus sayısını gecmemesi icin
	if rand < olasilik_matris(floor(i/60)+1)
		yolcu(size(yolcu,1)+1,:) = [0 i 0 0]; % yeni yolcu olustur
	end
end

yolcu_sayac = 1;
ortalamalar=[];
bekleme_sureleri=[];
bekleme_suresi=[];
 for i = 1 : size(otobusler,2)
    for k=1:size(otobusler,1)
        for j = yolcu_sayac : size(yolcu)
            yolcu(yolcu_sayac,1) = j; 
            if yolcu(j,2) <= otobusler(k,i)
                yolcu(j,3) = otobusler(k,i);
                yolcu(j,4) = yolcu(j,3) - yolcu(j,2);  
                yolcu_sayac = yolcu_sayac + 1;
            end
            bekleme_suresi(j,1)=yolcu(j,4);
        end
    end 
    yolcu_sayac=1;
    bekleme_sureleri=[bekleme_sureleri bekleme_suresi];
 end
ortalamalar=mean(bekleme_sureleri);


for i=1:100
    nesil(i,:)=[mutation(yolcu,otobusler) natural_selection(yolcu,otobusler) cross_over(otobusler,yolcu)];
end
y=mean(nesil');


x=1:2:200;
figure
plot(x,y,'Marker','.','MarkerSize',20,'Color','r');
