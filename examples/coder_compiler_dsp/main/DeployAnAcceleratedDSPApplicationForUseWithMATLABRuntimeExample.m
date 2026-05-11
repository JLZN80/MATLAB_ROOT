%% Use Generated Code to Accelerate an Application Deployed  with MATLAB Compiler
% This example shows how to use generated code to accelerate an application  
% that you deploy with MATLAB&#0174; Compiler. The example accelerates 
% an algorithm by using MATLAB&#0174; Coder&#8482; to generate a MEX version of the algorithm.  
% It uses MATLAB Compiler to deploy a standalone application that calls the MEX function.    
% The deployed application uses the MATLAB&#0174; Runtime which enables
% royalty-free deployment to someone who does not have MATLAB.
%
% This workflow is useful when:
%
% * You want to deploy an application to a platform that the 
% MATLAB Runtime supports.
% * The application includes a computationally intensive algorithm that is
% suitable for code generation.
% * The generated MEX for the algorithm is faster than the original MATLAB
% algorithm.
% * You do not need to deploy readable C/C++ source code for the application.
%
% The example application uses a DSP algorithm that requires the
% DSP System Toolbox&#8482;. 
%% Create the MATLAB Application
%
% For acceleration, it is a best practice to separate the computationally
% intensive algorithm from the code that calls it.
%
% In this example, |myRLSFilterSystemIDSim| implements the algorithm.  
% |myRLSFilterSystemIDApp| provides a user interface that calls 
% |myRLSFilterSystemIDSim|. 
%
% |myRLSFilterSystemIDSim| simulates system identification by 
% using recursive least-squares (RLS) adaptive filtering. The algorithm uses 
% |dsp.VariableBandwidthFIRFilter| to model the unidentified system and
% |dsp.RLSFilter| to identify the FIR filter.
% 
% |myRLSFilterSystemIDApp| provides a user interface that you use to 
% dynamically tune simulation parameters. It runs the simulation for a
% specified number of time steps or until you stop the simulation. It plots
% the results of the simulation on scopes.
% 
% For details about this application, see
% <docid:dsp_ug.example-RLSFilterSystemIdentificationExample System Identification Using RLS Adaptive Filtering> in the
% DSP System Toolbox documentation.
%% 
% In a writable folder, create |myRLSFilterSystemIDSim| and
% |myRLSFilterSystemIDApp|. Alternatively, to access these files, click
% *Open Script*.
%%
%
% *myRLSFilterSystemIDSim*
%
% <include>myRLSFilterSystemIDSim.m</include>
%%
% *myRLSFilterSystemIDApp*
%
% <include>myRLSFilterSystemIDApp.m</include>
%

%% Test the MATLAB Application
% Run the system identification application for 100 time steps. 
% The application runs the simulation for 100 time steps or until you click 
% *Stop Simulation*. It plots the results on scopes.
scope1 = myRLSFilterSystemIDApp(100);
release(scope1.tfescope);
release(scope1.msescope);
%% Prepare Algorithm for Acceleration
% 
%% 
% When you use MATLAB Coder to accelerate a MATLAB algorithm, the code must
% be suitable for code generation.
%
% 1. Make sure that |myRLSFilterSystemIDSim.m| includes the |%#codegen|
% directive after the function signature. 
%
% This directive indicates that you intend to generate code for the
% function. In the MATLAB Editor, it enables the code analyzer to detect 
% code generation issues.
%
% 2. Screen the algorithm for unsupported functions or constructs.
%
%   coder.screener('myRLSFilterSystemIDSim');
%
% <<../screener_output.png>>
%
% The code generation readiness tool does not find code generation issues in 
% this algorithm.
%% Accelerate the Algorithm
%
% To accelerate the algorithm, this example use the MATLAB Coder |codegen|
% command. Alternatively, you can use the MATLAB Coder app. For code generation, 
% you must specify the type, size, and complexity of the input arguments. 
% The function |myRLSFilterSystemIDSim| takes a structure that stores tuning 
% information. Define an example tuning structure and pass it to |codegen|
% by using the |-args| option.
ParamStruct.TuningValues = [2400 0.99];
ParamStruct.ValuesChanged = false;
ParamStruct.Reset = false;
ParamStruct.Pause = false;
ParamStruct.Stop  = false;
codegen myRLSFilterSystemIDSim -args {ParamStruct};
%%
% |codegen| creates the MEX function |myRLSFilterSystemIDSim_mex| in the
% current folder.
%% Compare MEX Function and MATLAB Function Performance
%% 
% 1. Time 100 executions of |myRLSFilterSystemIDSim|.
clear myRLSFilterSystemIDSim
disp('Running the MATLAB function ...')
tic
nTimeSteps = 100;
for ind = 1:nTimeSteps
     myRLSFilterSystemIDSim(ParamStruct);
end
tMATLAB = toc;
%% 
% 2. Time 100 executions of |myRLSFilterSystemIDSim_mex|.
clear myRLSFilterSystemIDSim
disp('Running the MEX function ...')
tic
for ind = 1:nTimeSteps
    myRLSFilterSystemIDSim_mex(ParamStruct);
end
tMEX = toc;

disp('RESULTS:')
disp(['Time for original MATLAB function: ', num2str(tMATLAB),...
     ' seconds']);
disp(['Time for MEX function: ', num2str(tMEX), ' seconds']);
disp(['The MEX function is ', num2str(tMATLAB/tMEX),...
    ' times faster than the original MATLAB function.']);
%% Optimize the MEX code
% You can sometimes generate faster MEX by using a different C/C++
% compiler or by using certain options or optimizations. See
% <docid:coder_ug.bsx_ir0 Accelerate MATLAB Algorithms>. 
%
% For this example, the MEX is sufficiently fast without further optimization. 
%% Modify the Application to Call the MEX Function
%%
% Modify |myRLSFilterSystemIDApp| so that it calls
% |myRLSFilterSystemIDSim_mex| instead of |myRLSFilterSystemIDSim|.
%%
% Save the modified function in |myRLSFilterSystemIDApp_acc.m|.
%% Test the Application with the Accelerated Algorithm
clear myRLSFilterSystemIDSim_mex;
scope2 = myRLSFilterSystemIDApp_acc(100);
release(scope2.tfescope);
release(scope2.msescope);

%%
% The behavior of the application that calls the MEX function is the same
% as the behavior of the application that calls the original MATLAB function. 
% However, the plots update more quickly because the simulation is faster.
%% Create the Standalone Application 
%%
% 1. To open the Application Compiler App, on the *Apps* tab, under 
% *Application Deployment*, click the app icon.
%%
% 2. Specify that the main file is |myRLSFilterSystemIDApp_acc|.
%
% The app determines the required files for this application.
% The app can find the MATLAB files and MEX-files that an
% application uses. You must add other types of files,
% such as MAT-files or images, as required files.
%%
% 3. In the *Packaging Options* section of the toolstrip, make sure that
% the *Runtime downloaded from web* check box is selected.
% 
% This option creates an application installer that downloads and 
% installs the MATLAB Runtime with the deployed MATLAB application.
%
% <<../compiler_app_dsp_example.png>>
%
%%
% 4. Click *Package* and save the project. 
%
%%
% 5. In the Package window, make  sure that the 
% *Open output folder when process completes* 
% check box is selected.
%
% <<../package_window.png>>
%
% When the packaging is complete, the output folder opens.
% 
%% Install the Application
%%
% 1. Open the |for_redistribution| folder.
%% 
% 2. Run |MyAppInstaller_web|.
%%
% 3. If you connect to the internet by using a proxy server, enter the server
% settings.
%%
% 4. Advance through the pages of the installation wizard. 
%
% * On the Installation Options page, use the default installation folder.
% * On the Required Software page, use the default installation folder.
% * On the License agreement page, read the license agreement and accept
% the license.
% * On the Confirmation page, click *Install*.
%
% If the MATLAB Runtime is not already installed, the installer installs it.
%
% 5. Click *Finish*.
%% Run the Application
%%
% 1. Open a terminal window.
%%
% 2. Navigate to the folder where the application is installed.
% 
% * For Windows&#0174;, navigate to |C:\Program
% Files\myRLSFilterSystemIDApp_acc|.
% * For macOS, navigate to  |/Applications/myRLSFilterSystemIDApp_acc|.
% * For Linux, navigate to |/usr/myRLSFilterSystemIDApp_acc|.
%%
% 3. Run the application by using the appropriate command for your platform.
% 
% * For Windows, use |application\myRLSFilterSystemIDApp_acc|.
% * For macOS, use
% |myRLSFilterSystemIDApp_acc.app/Contents/MacOS/myRLSFilterSystemIDApp_acc|.
% * For Linux, use |/myRLSFilterSystemIDApp_acc|. 
%
% Starting the application takes approximately the same amount of time as 
% starting MATLAB.




%% 
% Copyright 2012-2019 The MathWorks, Inc.