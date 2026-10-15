# Set Mailbox Auditing Policies
Ensure all auditable events are enabled on mailboxes, such as MailItemsAccessed, SearchQueryInitiated, and PreservedMailItemProactively

## Prerequisites
- PowerShell 7.6 or later. In Azure Automation, select the PowerShell 7.6 [Runtime environment](https://learn.microsoft.com/en-us/azure/automation/automation-runbook-types#powershell-runbooks). Azure Automation source control integration does not support PowerShell 7.6; configure the runtime explicitly.
- A compatible [ExchangeOnlineManagement module](https://learn.microsoft.com/en-us/powershell/exchange/exchange-online-powershell-v2#prerequisites-for-the-exchange-online-powershell-module) installed in that runtime.
- A managed identity with the limited Exchange permissions described in the setup comments at the end of Set-MailboxAuditing.ps1.

Set $tenantName to your tenant domain before running. The runbook connects with the managed identity and updates all user, shared, room, and equipment mailboxes. Review the audit settings and permissions before using it in your tenant.

The audit settings are shared across the four mailbox selections. This reduces duplication without changing their filters, processing order, or Exchange command count.
