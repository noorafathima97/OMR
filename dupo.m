I = imread('C:\Users\CCF\Desktop\music.jpg');
J = imnoise(I,'salt & pepper',0.02);
K = medfilt3(J);
imshow(K);
title('Noise Removal')
L = rgb2gray(K);
bw_image= imbinarize(L,'adaptive','ForegroundPolarity','dark','Sensitivity',0.44);
imshow(J)
title('Binarization')
 se_line = strel('line', length(bw_image)*0.005, 0);
    bw_image = imerode(bw_image, se_line);
    [pks, locs] = findpeaks(sum(bw_image,2));
    tresh = pks > max(pks)/5;
    locs = locs .* tresh;
    pks = pks .* tresh;

    pks_tresh = pks(pks~=0);
    locs_tresh = locs(locs~=0);
    staff_lines = [];
    if mod(length(locs_tresh), 5) == 0
        staff_lines = locs_tresh;
    else
        staff_lines = locs_tresh; 
         while ~ mod(length(staff_lines), 5) == 0
            index = find(pks_tresh == min(pks_tresh));
            pks_tresh(index) = [];
            staff_lines(index) = [];
            
            pks_tresh = pks_tresh(pks_tresh~=0);
            staff_lines = staff_lines(staff_lines~=0);
        end
    end
        if ~isempty(staff_lines)
        
        % ------ CLEAN UP IMAGES 

        % Remove staff lines
        %bw_no_sl = remove_stafflines(bw, staff_lines);
out_imageage = bw_image;
    for i=1:length(staff_lines(:))
out_imageage(staff_lines(i)-1, :) = 0;
        out_imageage(staff_lines(i), :) = 0;
        out_imageage(staff_lines(i)+1, :) = 0;
    end

        % Identify positions to split into subimages for each row block
        %split_positions = get_split_positionsitions(bw, staff_lines);
        split_positionsitions(1) = max(staff_lines(1)-50, 1);
    for i=5:5:length(staff_lines(:))-1
        split_positionsitions(end+1) = ceil(staff_lines(i) ...
            + ((staff_lines(i+1) - staff_lines(i)) / 2));
    end
    split_positionsitions(end+1) = length(bw_image(:,1));

        % Calcualate the number of subimages 
        n = length(split_positionsitions)-1;

        % Split bw and bw without staff lines into subimages
        %subimg = split_images(bw_image,split_positionsitions);
      %  subimg_no_sl = split_images(bw_no_sl, split_positionsitions);     
 out_image = [];
    for i=1:length(split_positions)-1
        out_image{i} = bw_image(split_positions(i):split_positions(i+1),:);
    end

        % Clean up holes where the staff lines where removed
        %subimg_clean = clean_image(subimg_no_sl, n);

        % Caluculate locations for staff lines in the subimages
       % subimg_staff_lines = map_stafflines_to_subimages(staff_lines, split_positions);
 
  %%%% % subimg_staff_lines = [];
   % for i=1:length(split_positions)-1
      %  for j=1:5
      %      subimg_staff_lines{i}(j) = staff_lines((i-1)*5+j) - split_positions(i);
      %  end
   % end 
        end
    for i=1:length(split_positions)-1
   figure;
    imshow(out_image)
    end