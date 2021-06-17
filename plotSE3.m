% Function to plot a SE(3) pose
%
% Function Parameters:
% g                 - SE(3) pose
%                     4 x 4 Matrix
%
% Variable Arguments:
% Scale             - Scale of Quiver Plot
% LineWidth         - Line width of Quiver Plot
% MaxHeadSize       - Arrow head size
% MarkerProp        - Marker shape and colour
% MarkerSize        - Size of marker
% MarkerLineWidth   - Line width of Marker
% ArrowLength       - Length of Quiver Plot arrows
%
% Function Output:
% plot_handle       - Plot handle of Marker

function plot_handle = plotSE3(g, varargin)
    
    plot_handle = [];
    
    arg_count = length(varargin);
    
    scale = 0;
    marker_prop = '';
    line_width = 1;
    arrowhead_size = 0.2;
    marker_size = 1;
    marker_line_width = 1;
    arrow_length = 1;
    
    quiver_prop_list = {'Scale', 'LineWidth', 'MaxHeadSize', 'MarkerProp', 'MarkerSize', 'MarkerLineWidth', 'ArrowLength'};
    prop_list_map = 1:length(quiver_prop_list);
    temp_list = quiver_prop_list;
    
    if mod(arg_count ,2) ~= 0
        error(message('plot_SE3:InvalidNumInputs'));
    end
    
    for i = 1:2:arg_count
        for j = 1:length(temp_list)
            if strcmp(varargin{i},temp_list{j})
                temp_list = setdiff(temp_list, {varargin{i}},'stable');
                
                switch prop_list_map(j)
                    case 1
                        if varargin{i+1} ~= 0
                            scale = varargin{i+1};
                        end
                    case 2
                        line_width = varargin{i+1};
                        marker_line_width = line_width;
                    case 3
                        arrowhead_size = varargin{i+1};
                    case 4
                        marker_prop = varargin{i+1};
                    case 5
                        marker_size = varargin{i+1};
                    case 6
                        marker_line_width = varargin{i+1};
                    case 7
                        arrow_length = varargin{i+1};
                end
                
                prop_list_map(j) = [];
                
                break;
            end
        end
    end
    
    g(1:3,1:3) = arrow_length * g(1:3,1:3);
    
    quiver3(g(1,4),g(2,4),g(3,4), ...
            g(1,1),g(2,1),g(3,1), ...
            scale, 'Color',[1 0 0], 'LineWidth', line_width, 'MaxHeadSize', arrowhead_size);
    quiver3(g(1,4),g(2,4),g(3,4), ...
            g(1,2),g(2,2),g(3,2), ...
            scale, 'Color',[0 1 0], 'LineWidth', line_width, 'MaxHeadSize', arrowhead_size);
    quiver3(g(1,4),g(2,4),g(3,4), ...
            g(1,3),g(2,3),g(3,3), ...
            scale, 'Color',[0 0 1], 'LineWidth', line_width, 'MaxHeadSize', arrowhead_size);
    
    if ~isempty(marker_prop)
        plot_handle = plot3(g(1,4),g(2,4),g(3,4), marker_prop, 'MarkerSize', marker_size, 'LineWidth', marker_line_width);
    end
end