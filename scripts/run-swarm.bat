@echo off
cd /d "C:\projekte\copilot-workflows"
start wt -w 0 powershell -NoExit -Command "Set-Location 'C:\projekte\copilot-workflows'; copilot --model auto --agent swarm-coordinator; Read-Host"
start wt -w 0 new-tab powershell -NoExit -Command "Set-Location 'C:\projekte\copilot-workflows'; copilot --model auto --agent tdd-coordinator; Read-Host"
start wt -w 0 new-tab powershell -NoExit -Command "Set-Location 'C:\projekte\copilot-workflows'; copilot --model auto --agent property-test-generator; Read-Host"
start wt -w 0 new-tab powershell -NoExit -Command "Set-Location 'C:\projekte\copilot-workflows'; copilot --model auto --agent crap-analyzer; Read-Host"
start wt -w 0 new-tab powershell -NoExit -Command "Set-Location 'C:\projekte\copilot-workflows'; copilot --model auto --agent git-orchestrator; Read-Host"