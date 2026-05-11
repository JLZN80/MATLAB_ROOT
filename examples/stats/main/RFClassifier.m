classdef RFClassifier < matlab.System
    % RFCLASSIFIER Predict image labels from trained random forest
    %
    % RFCLASSIFIER loads the trained random forest from
    % |'DigitImagesRF.mat'|, and predicts labels for new observations based
    % on the trained model.  The random forest in |'DigitImagesRF.mat'|
    % was cross-validated using the training data in the sample data
    % |digitimages.mat|.

    properties(Access = private)
        CompactMdl % The compacted, trained random forest
    end
        
    methods(Access = protected)
        
        function setupImpl(obj)
            % Load random forest from file
            obj.CompactMdl = loadLearnerForCoder('DigitImagesRF');
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
