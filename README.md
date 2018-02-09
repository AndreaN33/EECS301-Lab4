# Lab #4 Assignment

## Objective

This lab introduces State Machine design for FPGA architectures.  State machines allow more complicated process flows to be implemented using FPGA logic. Many of the design skills learned in the previous labs are required to create a State Machine.  The lab goes over the basic structure and HDL constructs used to construct the State Machine code, leaving the high-level design considerations for later labs.

The lab also goes into more depth on the automated verification testing using the simulator seen in the first lab.  Automated testing is a valuable tool to insure design reliability.  Such testing can be used during development to initially verify a design, then used later on for regression testing to verify other changes to the system have not broken the original functionality.

## Assignment Overview

* Retrieve the Lab Assignment from GitHub
* Create the Quartus Project
* Follow the [**Lab 4 Project Guide**](Lab4-Guide/Lab4-ProjectGuide.md)
* [Lab Report Write-up](#lab-report-requirements)
* Commit, tag, and push all modified lab files to **GitHub** following the [**Submission Guide**](Lab4-Guide/GitHub-SubmissionGuide.md)
* Submit the Report PDF to **Canvas**

## Assignment Details

1. Retrieve the **Lab 4 Assignment** repository from GitHub.

	An e-mail with the **Lab 4 Assignment Invitation Link** should have been received, if not, contact an instructor.  Opening the Invitation Link and accepting the assignment will create a new private GitHub repository labeled with your GitHub username (***lab4-assignment-username***).

	* The Lab 4 Assignment repository can be found here: [GitHub EECS301](https://github.com/CWRU-EECS301-S18)
	* Clone the ***lab4-assignment-username*** repository to your development machine using the same procedures outlined in the **Lab 1 Git Tutorial**.

1. Create the Quartus Project for the lab assignment following the same _New Project Wizard_ procedure used the previous labs with the parameters listed below.

	* Set the project working directory to the `Lab4-Project` directory of the Lab Assignment Repository.
	* Name the project: `EECS301_Lab4_Project`
	* Name the top level design entity: `EECS301_Lab4_TopLevel`
	* Add the following Framework files to the project:

		```
		EECS301_Lab4_TopLevel.v
		EECS301_Lab4_Project.sdc
		BCD_Binary_Encoder.v
		BCD_Segment_Decoder.v
		CDC_Input_Synchronizer.v
		Calculator_Module.v
		Calculator_Full_Adder.v
		FxP_ABS_Function.v
		Key_Command_Controller.v
		Key_Synchronizer_Bank.v
		Key_Synchronizer_Module.v
		Switch_Debounce_Synchronizer.v
		Switch_Synchronizer_Bank.v
		System_Reset_Module.v
		StdFunctions.vh
		TF_EECS301_Lab4_TopLevel.v  (Verilog Test Bench)
		TF_BCD_Segment_Decoder.v    (Verilog Test Bench)
		TF_BCD_Binary_Encoder.v     (Verilog Test Bench)
		```
	
	* Remember to set the file type to **Verilog Test Bench** for the Test Bench files.
	* :warning: Import the Pin Assignment file: `Lab4_Project_Assignments.qsf`
	* Check Pin Planner to verify the Pin Assignments were imported correctly.
	* Refer back to the previous lab's Quartus Guides for help on any of the steps.

1. The [**Lab 4 Project Guide**](Lab4-Guide/Lab4-ProjectGuide.md) will provide the main implementation details for the lab assignment. 

1. Write the lab report following the [**Lab Report Requirements**](#lab-report-requirements) detailed in the next section.

1. Submit the assignment (including all code, project files, and lab report) back to GitHub following the [**Lab Assignment Submission Guide**](Lab4-Guide/GitHub-SubmissionGuide.md).

1. Submit the lab report in PDF format to **Canvas**.

	
## Lab Report Requirements

Include the following in the lab report:

* The **Introduction** section should give a brief description of the overall functionality of the project and the new concepts learned about in the lab.

* The **Implementation Details** section should include a functional description for each of the four [Implementation Modules](Lab4-Guide/Lab4-ProjectGuide.md#implementation-reference-list) and what new techniques were learned from the modules.

* The **Verification Results** section should include the waveform captures and the automated testing messages in the Transcript window (showing zero errors) from the two simulations included with the lab.   If the first run of the simulation had problems, mention what the problems were and your debugging steps to solve the problem.

* The **Conclusions** section should summarize what was learned from the implementation and verification tasks.

* In the remaining sections provide an estimate of the time spent doing the lab and any issues or difficulties encountered.


## Lab Due Date

The lab project and report will be due by 3:00pm on **Feb 16, 2018**.

All files and code must be committed and pushed to GitHub by the submission deadline.  The submission process is detailed in the [**Lab Submission Guide**](Lab4-Guide/GitHub-SubmissionGuide.md).

The PDF version of the lab report also needs to be submitted to Canvas by the same submission deadline.

## Grading Rubric

**Lab 4 is worth 150 Points Total:**

*   50 points for the correct implementation of **BCD\_Segment\_Decoder** module
*   10 points for the simulation screenshots of the **TF\_BCD\_Segment\_Decoder** Test Bench waveform and the Transcript message window showing 0 test errors
	* NOTE: This can be a single image showing both windows.
*   10 points for the correct implementation of **Calculator\_Module** module
*   30 points for the correct implementation of **BCD\_Binary\_Encoder** module 
*   10 points for the simulation screenshots of the **TF\_BCD\_Binary\_Encoder** Test Bench waveform and the Transcript message window showing 0 test errors
	* NOTE: This can be a single image showing both windows.
*   10 points for a correct verification of the operation of the Calculator by a TA.
*   20 points for the content of the lab report
*   5 points for the completed lab report submitted in Markdown format to GitHub repo
*   5 points for the completed lab report in PDF format submitted to Canvas
