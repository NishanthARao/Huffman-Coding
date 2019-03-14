%[0.4 0.2 0.1 0.1 0.1 0.05 0.05]
%Clear the console, variable history and any plot windows.
clc;clear;close;

%Initialise some important variables.
li = [0];       %length of each code word.
j = 0;          %Plays role in for loops.
variance = 0;   %variance of the code.

%Input the probability values and sort them in descending order. Store the number of elements in variable 'l'. 
p = input('Enter the probability values here: ');
p = sort(p,'descend');
pi = p;                     %Store a copy of probabilities for variance and average length calculations.
l = length(p);              %store the number of source variables. 
identity_map = (1:l);       %Create a vector (that evolves into a matrix in further computations) to keep track of the composite symbols and to which places they ascend in the tree.
code_map = (1:l);           %Create a vector that will hold the symbols for each source.
code_map = cellstr(num2str(code_map));  %Convert this vector to a cell as there will be different sizes of string elements.
%disp(code_map);
%disp(identity_map);
i = l;

%This while loop performs the tree operation, where the composite code is
%placed as high as possible to achieve minimum variance. The track of
%composite symbols are computed in the eventually formed matrix
%identity_map.
while(l > 2)
    identity_map(i-l+2,:) =  identity_map(i-l+1,:);
    %disp(l);
    sum = p(l) + p(l-1);
    idSum = str2double(string(identity_map(i-l+2,l-1)) + string(identity_map(i-l+2,l)));
    
    for k=1:l
        if(sum > p(k) || sum == p(k))
            index = k;
            %disp(index);
            break;
        end
    end
    
    k = l;
    
    while(k > index)
        p(k) = p(k-1);
        identity_map(i-l+2,k) = identity_map(i-l+2,k-1);
        k = k-1;
    end
    
    p(index) = sum;
    identity_map(i-l+2,index) = idSum;
    p(end) = [];
    
    for h = 0:j
        identity_map(i-l+2,i-h) = 0;
    end
    
    l = l-1;
    %break;
    %disp(p);
    j = j+1;
end

%Restore the value of l to number of source variables. Transpose the matrix
%identity_map for ease of calculations.
l = i;
identity_map = identity_map';

%disp(l);
%disp(identity_map);

%Compute the symbols for each source variables.
q = 0;w= 0;
while(l>1)
    %disp(length(num2str(identity_map(l-1,i-l+1))-'0'));
    %disp(length(num2str(identity_map(l,i-l+1))-'0'));
    if(length(num2str(identity_map(l-1,i-l+1))-'0') == 1 && length(num2str(identity_map(l,i-l+1))-'0') == 1)
        code_map(identity_map(l-1,i-l+1)) = cellstr(string(0));
        code_map(identity_map(l,i-l+1)) = cellstr(string(1));
    else
        q = num2str(identity_map(l-1,i-l+1))-'0';
        w = num2str(identity_map(l,i-l+1))-'0';
        if(length(q) == 1)
            code_map(identity_map(l-1,i-l+1)) = cellstr(string(0));
        else
            for a_ = 1:length(q)
                h = (string(code_map(q(a_)))+string(0));
                code_map(q(a_)) = cellstr(h);
                
            end
        end
        
        if(length(w) == 1)
            code_map(identity_map(l,i-l+1)) = cellstr(string(1));  
        else
            for a_ = 1:length(w)
                code_map(w(a_)) = cellstr((string(code_map(w(a_)))+string(1)));
            end
        end
    end
    l = l-1;
end

%Reverse the codes to get right code for each source variable.
code_map = reverse(code_map(:));

%Compute the length of every code word and store it in a row vector li.
for j = 1:i
    li(j) = length(char(string(code_map(j))));
end

%Compute the average length by performing inner product operation.
L = li*pi';

%Compute the variance:
for j=1:i
    variance = variance + ((li(j)-L)^2)*pi(j);
end

%Display the result.
fprintf("The following Huffman coding for the source provides minimum variance of %4.2f:\n",variance);
for j = 1:i
    fprintf("S%d --> %s\n",j,string(code_map(j)));
end