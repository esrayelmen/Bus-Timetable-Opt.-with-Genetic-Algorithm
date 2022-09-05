function mutationn=mutation(yolcu,otobusler)
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

pmutation = 15;
rs = 10;
yolcu_sayac = 1;
mutationn=[];

for z=1:20
    rast=randi(size(otobusler,1)); %rast=randi(size(otobusler,1));
    rast2=randi([1,50]); 
    if otobusler(rast,rast2)==0
        rast=rast-20;
    end
    for i = 1:size(otobusler,2)
        for j=1:size(otobusler,1)
            if i==rast2 && j==rast
                A=otobusler(j,i);
                otobusler(j,i)=otobusler(j,i)-rs;
                for k = yolcu_sayac : size(yolcu)
                    if yolcu(k,3) == A && yolcu(k,2)<otobusler(j,i) 
                        yolcu(k,3) = otobusler(j,i);
                        yolcu(k,4) = yolcu(k,3) - yolcu(k,2); 
                        bekleme_sureleri(k,i)=yolcu(k,4);
                        yolcu_sayac = yolcu_sayac + 1;
                    elseif yolcu(k,3) == A && yolcu(k,2)>=otobusler(j,i)
                        j=j+1;
                        yolcu(k,3) = otobusler(j,i);
                        yolcu(k,4) = yolcu(k,3) - yolcu(k,2);
                        bekleme_sureleri(i,j)=yolcu(k,4);
                        yolcu_sayac = yolcu_sayac + 1;  
                    end
                end
                mutationn(:,z)=mean(bekleme_sureleri(:,i));
            end
        end
    end
end