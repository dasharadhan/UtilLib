% Function to plot the trajectory of a given SE(3) sequence of poses
%
% Function Parameters:
% g                 - SE(3) pose
%                     4 x 4 Matrix
% Variable Arguments:
% LineWidth         - Line width
% LineStyle         - Line Style
% LineColour        - Line Colour
% MarkerShape       - Shape of marker
%
% Function Output:
% plot_handle       - Plot handle

function plot_handle = plotSE3Trajectory(g_seq, varargin)
    
    line_width = 1;
    line_spec = '-';
    
    prop_list = {'LineWidth', 'LineStyle', 'LineColour', 'MarkerShape'};
    prop_list_map = 1:length(prop_list);
    temp_list = prop_list;
    
    arg_count = length(varargin);
    
    if mod(arg_count ,2) ~= 0
        error(message('plotSE3Trajectory():InvalidNumInputs'));
    end
    
    for i = 1:2:arg_count
        for j = 1:length(temp_list)
            if strcmp(varargin{i},temp_list{j})
                temp_list = setdiff(temp_list, {varargin{i}},'stable');
                
                switch(prop_list_map(j))
                    case 1
                        line_width = varargin{i+1};
                    case 2
                        line_spec(1) = varargin{i+1};
                    case 3
                        if(varargin{i+1} ~= 0)
                            line_spec(2) = varargin{i+1};
                        end
                    case 4
                        line_spec(3) = varargin{i+1};
                end
                
                prop_list_map(j) = [];
                
                break;
            end
        end
    end
    
    x_vals = g_seq(1,4,1:end);
    x_vals = reshape(x_vals,1,size(x_vals,3));
    y_vals = g_seq(2,4,1:end);
    y_vals = reshape(y_vals,1,size(y_vals,3));
    z_vals = g_seq(3,4,1:end);
    z_vals = reshape(z_vals,1,size(z_vals,3));
    plot_handle = plot3(x_vals,y_vals,z_vals, line_spec, 'LineWidth', line_width);

end