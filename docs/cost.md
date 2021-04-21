# Cost Analysis

## Import Information
As this tool spins up cloud resources, it will result in charges to your Azure account.  Efforts have been made to minimize the costs incurred, but the tool author is not responsible for any charges or security issues that may result from usage of this tool.  Be sure to tear down all resources when not using them.

## Azure Cost Analysis
Based on the default enabled modules, the projected cost is about $266 a month or $8.76 per day.  This cost might vary so be sure to check Azure Cost Analysis feature on a daily basis to measure the cost.  The majority of the cost is for the Velocihelk system, because it is used for data science use cases (it needs to install a larger hardware size).  Here is a breakdown of the VM sizes and associated costs for each module:

### Price Breakdown Per Azure Module
| Module Name | Azure VM Size   | Estimated Daily | Estimated Monthly |
|-------------|-----------------|-----------------|-------------------|
| velocihelk  | Standard_DS3_v2 |      $7         |       $213        |      
|     Win10   | Standard_DS1_v2 |      $1.76      |       $53         |      


| Total Daily | Total Monthly   |
|-------------|-----------------|
|   $8.76     |     $266        |
