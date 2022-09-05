function rulet_sec=natural_selection(yolcu,otobusler)
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

% Turnuva secimi
% turnuva_sec=[];
% for j=1:10
%     rastgele=randi(length(ortalamalar));
%     turnuva_sec(:,j)=ortalamalar(rastgele);
% end

%Dogal secilim
% dogal_sec=[];
% A=reshape(ortalamalar,5,10);
% dogal_sec=min(A);
%


% Rulet carkı secimi
rulet_ort=ortalamalar/(sum(ortalamalar));
rulet_sec=[];
for j=1:50
    rastgele=randi(length(rulet_ort));
    top=0;
    sec=0;
    for i=1:size(rulet_ort,2)
        if top <= rulet_ort(rastgele)
            top=top+rulet_ort(i);
        else
            sec=ortalamalar(i);
            break
        end
    end
    rulet_sec(:,j)=sec;
end




