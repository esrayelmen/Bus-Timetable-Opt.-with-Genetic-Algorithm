function en_iyi_ort=cross_over(otobusler,yolcu)
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

sirali_ort = sort(ortalamalar);
for i = 1:size(sirali_ort,2)
    [row,col]=find(ortalamalar==sirali_ort(1,i));
    if size(col,2)>=1
        [row,col]=find(ortalamalar==sirali_ort(1,i),1);
    end
    sirali_ort(2,i)=col;
end

for i = 1:size(sirali_ort,2)
    index = sirali_ort(2,i);
    sirali_otobusler(:,i) = otobusler(:,index);
end
psize = size(sirali_otobusler, 2);

ciftler=randperm(psize);
d=size(sirali_otobusler, 1);
for i=1:psize/2
    parent1idx=ciftler(2*i-1);
    parent2idx=ciftler(2*i);
    parent1=sirali_otobusler(:,parent1idx);
    parent2=sirali_otobusler(:,parent2idx);
    
    capr_nok=unidrnd(d); 
        dummy=parent1(capr_nok+1:end);%parent1'in çaprazlanacak kısmını tutmak için!!
        parent1(capr_nok+1:end)=parent2(capr_nok+1:end);%parent1 in genini parent2nin sonuyla değiştirdim!!
        parent2(capr_nok+1:end)=dummy;
        sirali_otobusler(:,parent1idx)=parent1;
        sirali_otobusler(:,parent2idx)=parent2;
end

yolcu_sayac = 1;
bekleme_sureleri=[];
bekleme_suresi=[];
for i = 1 : size(sirali_otobusler,2)
    for k=1:size(sirali_otobusler,1)
        for j = yolcu_sayac : size(yolcu)
            yolcu(yolcu_sayac,1) = j; 
            if yolcu(j,2) <= sirali_otobusler(k,i)
                yolcu(j,3) = sirali_otobusler(k,i);
                yolcu(j,4) = yolcu(j,3) - yolcu(j,2);  
                yolcu_sayac = yolcu_sayac + 1;
            end
        end
        bekleme_suresi=yolcu(:,4);
    end 
    yolcu_sayac=1;
    sirali_ort(3,i)=mean(bekleme_suresi);
end
en_iyi_ort=[];
j=0;
for i=1:size(sirali_ort,2)
    if sirali_ort(3,i)<=sirali_ort(1,i)
         j=j+1;
            en_iyi_ort(:,j)=sirali_ort(3,i);
            ortalamalar(:,sirali_ort(2,i))=sirali_ort(3,i);
            if j==20
                break;
            end
    end
end

