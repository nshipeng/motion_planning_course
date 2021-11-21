clc;
clear;
c1 = 1.49445;
c2 = 1.49445;

maxgen = 300;
sizepop = 20;

popmax = 2;popmin = -2;
vmax = 0.5;vmin = -0.5;

for i = 1 : sizepop
    pop(i,:) = popmax * rands(1,2);
    V(i,:) = vmax * rands(1,2);
    fitness(i) = fun(pop(i,:));
end

[bestfitness, bestindex] = min(fitness);
zbest = pop(bestindex,:);
gbest = pop;
fitnessgbest = fitness;
fitnesszbest = bestfitness;

for i = 1:maxgen
    for j = 1 : sizepop
        V(j,:) = V(j,:) + c1 * rand * (gbest(j,:) - pop(j,:)) + c2 * rand * (zbest - pop(j ,:));
        V(j , find(V(j,:))> vmax) = vmax;
        V(j , find(V(j,:))<  vmin) = vmin;
        
        pop(j,:) = pop(j,:) + 0.5 * V(j,:);
        pop(j, find(pop(j,:)> popmax)) = popmax;
        pop(j, find(pop(j,:)< popmin)) = popmin;
        
        fitness(j)  = fun(pop(j,:));
    end
    
    for j = 1:sizepop
        if fitness(j) > fitnessgbest(j)
            gbest(j,:) = pop(j,:);
            fitnessgbest(j) = fitness(j);
        end
        
        if fitness(j) > fitnesszbest
            zbest = pop(j, :);
            fitnesszbest = fitness(j);
        end
    end
    
    result(i) = fitnesszbest;
end

plot(result);




