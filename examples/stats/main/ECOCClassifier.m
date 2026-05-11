classdef ECOCClassifier < matlab.System
    % ECOCCLASSIFIER Predict image labels from trained ECOC model
    %
    % ECOCCLASSIFIER loads the trained ECOC model from
    % |'DigitImagesECOC.mat'|, and predicts labels for new observations
    % based on the trained model.  The ECOC model in
    % |'DigitImagesECOC.mat'| was cross-validated using the training data
    % in the sample data |digitimages.mat|.

    properties(Access = private)
        CompactMdl % The compacted, trained ECOC model
    end
        
    methods(Access = protected)
        
        function setupImpl(obj)
            % Load ECOC model from file
            obj.CompactMdl = loadLearnerForCoder('DigitImagesECOC');
        end
        
        function y = stepImpl(obj,u)
            y = predict(obj.CompactMdl,u);
        end
        
        function flag = isInputSizeMutableImpl(obj,index)
            % Return false if input size is not allowed to change while
            % system is running
            flag = false;
        end
        
        function dataout = getOutputDataTypeImpl(~)
            dataout = 'double';
        end
        
        function sizeout = getOutputSizeImpl(~)
            sizeout = [1 1];
        end
    end
end
