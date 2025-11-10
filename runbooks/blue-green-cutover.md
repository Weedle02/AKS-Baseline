# Blue/Green Cutover
1. Deploy candidate (green) via workflow.
2. Validate smoke tests and basic load.
3. Approval in GitHub Environment: Production.
4. Increase NGINX canary weight to 100% (values-green.yaml) or flip Service selector.
5. Monitor KQL dashboards for error spike and latency.
6. If issues, rollback per `rollback.md`.
