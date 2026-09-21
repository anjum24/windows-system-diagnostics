**Windows System Health \& Diagnostics Tool (PowerShell)**



**Overview**

This project contains a PowerShell script that automates common system‑health checks used in IT support. It collects key diagnostic information to help technicians quickly assess the state of a Windows machine.



The goal is to streamline troubleshooting, reduce repetitive manual checks, and provide consistent system snapshots.



**Features**



OS version and build information



CPU and RAM usage snapshot



Disk space report for all drives



Installed applications list



Network configuration (IP, DNS, gateway)



Connectivity test (ping)



Event Viewer error summary (last 24 hours)



**Script**



File: system-diagnostics.ps1



The script outputs results to the console and can optionally save them to a .txt file.



**How to Run**



Download or clone this repository.



Open PowerShell as Administrator.



Run the script using the command: .\\system-diagnostics.ps1







**(Optional) Save output to a file**: Run the below command to save the output to text file





.\\system-diagnostics.ps1 > diagnostics-output.txt



**Example Output**



**System Information**

**------------------**

**OS Version: Windows 10 Pro (Build 19045)**

**CPU Usage: 12%**

**RAM Usage: 48%**

**Disk Space: C:\\ 120GB free / 256GB total**



**Network**

**-------**

**IP Address: 192.168.1.20**

**DNS: 8.8.8.8**

**Gateway: 192.168.1.1**

**Ping Test: Success**



**Event Viewer (Last 24 Hours)**

**----------------------------**

**Errors Found: 3**

**- Application Error: Event ID 1000**

**- Service Control Manager: Event ID 7001**





