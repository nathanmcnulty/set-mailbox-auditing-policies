#Requires -Modules ExchangeOnlineManagement
<# 
.SYNOPSIS  
    Enables all available audit records and adds protection from disabling default auditing
    
.DESCRIPTION 
    This runbook ensures all available audit records are enabled for the mailbox types specified. It also ensures auditing is enabled and set to 365 in case default aduting is accidentally disabled.
    Prereq:    
    1. Runtime environment with ExchangeOnlineManagement modules
    2. Setup Managed Identiy and required permissions (see comments at end, blog post will be added here later) 

.NOTES 
    Author: Nathan McNulty 
    Details: https://nathanmcnulty.com/blog/2023/01/azure-automation-advanced-auditing/
    Last Updated: 02/21/2025  
#> 

$tenantName = "yourdomain.onmicrosoft.com"

# Connect to Exchange Online
Connect-ExchangeOnline -ManagedIdentity -Organization $tenantName

# Enable advanced auditing for user mailboxes
(Get-EXOMailbox -ResultSize Unlimited -Filter { RecipientTypeDetails -eq "UserMailbox" }).PrimarySmtpAddress | ForEach-Object { 
    Write-Output $_
    Set-Mailbox -Identity $_ -AuditEnabled $true -AuditLogAgeLimit 365 -AuditAdmin @{add='Update, Copy, Move, MoveToDeletedItems, SoftDelete, HardDelete, FolderBind, SendAs, SendOnBehalf, MessageBind, Create, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, Send, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'} -AuditDelegate @{add='Update, Move, MoveToDeletedItems, SoftDelete, HardDelete, FolderBind, SendAs, SendOnBehalf, Create, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'} -AuditOwner @{add='Update, Move, MoveToDeletedItems, SoftDelete, HardDelete, Create, MailboxLogin, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, Send, SearchQueryInitiated, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'}
}

# Enable advanced auditing for shared mailboxes
# NOTE: Requires additional license applied to mailbox or you will see errors, adjust filter as needed
# (Get-EXOMailbox -ResultSize Unlimited -Filter { RecipientTypeDetails -eq "SharedMailbox" }).PrimarySmtpAddress | ForEach-Object {
#    Write-Output $_
#    Set-Mailbox -Identity $_ -AuditEnabled $true -AuditLogAgeLimit 365 -AuditAdmin @{add='Update, Copy, Move, MoveToDeletedItems, SoftDelete, HardDelete, FolderBind, SendAs, SendOnBehalf, MessageBind, Create, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, Send, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'} -AuditDelegate @{add='Update, Move, MoveToDeletedItems, SoftDelete, HardDelete, FolderBind, SendAs, SendOnBehalf, Create, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'} -AuditOwner @{add='Update, Move, MoveToDeletedItems, SoftDelete, HardDelete, Create, MailboxLogin, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, Send, SearchQueryInitiated, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'}
#}

# Enable advanced auditing for room mailboxes
(Get-EXOMailbox -ResultSize Unlimited -Filter { RecipientTypeDetails -eq "RoomMailbox" }).PrimarySmtpAddress | ForEach-Object { 
    Write-Output $_
    Set-Mailbox -Identity $_ -AuditEnabled $true -AuditLogAgeLimit 365 -AuditAdmin @{add='Update, Copy, Move, MoveToDeletedItems, SoftDelete, HardDelete, FolderBind, SendAs, SendOnBehalf, MessageBind, Create, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, Send, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'} -AuditDelegate @{add='Update, Move, MoveToDeletedItems, SoftDelete, HardDelete, FolderBind, SendAs, SendOnBehalf, Create, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'} -AuditOwner @{add='Update, Move, MoveToDeletedItems, SoftDelete, HardDelete, Create, MailboxLogin, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, Send, SearchQueryInitiated, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'}
}

# Enable advanced auditing for equipment mailboxes
(Get-EXOMailbox -ResultSize Unlimited -Filter { RecipientTypeDetails -eq "EquipmentMailbox" }).PrimarySmtpAddress | ForEach-Object {
    Write-Output $_
    Set-Mailbox -Identity $_ -AuditEnabled $true -AuditLogAgeLimit 365 -AuditAdmin @{add='Update, Copy, Move, MoveToDeletedItems, SoftDelete, HardDelete, FolderBind, SendAs, SendOnBehalf, MessageBind, Create, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, Send, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'} -AuditDelegate @{add='Update, Move, MoveToDeletedItems, SoftDelete, HardDelete, FolderBind, SendAs, SendOnBehalf, Create, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'} -AuditOwner @{add='Update, Move, MoveToDeletedItems, SoftDelete, HardDelete, Create, MailboxLogin, UpdateFolderPermissions, AddFolderPermissions, ModifyFolderPermissions, RemoveFolderPermissions, UpdateInboxRules, UpdateCalendarDelegation, RecordDelete, ApplyRecord, MailItemsAccessed, UpdateComplianceTag, Send, SearchQueryInitiated, AttachmentAccess, PriorityCleanupDelete, ApplyPriorityCleanup, PreservedMailItemProactively'}
}


# NOTE: If you would prefer to run deltas, you can add "whenChanged" to the -Filter of the Get-EXOMailbox commands like this:
# Get-EXOMailbox -Filter "whenChanged -gt '$((Get-Date).AddDays(-1))' -and RecipientTypeDetails -eq 'UserMailbox'"


<# SETUP FOR MANAGED IDENTITY
Note: May need Global Admin to consent to Graph PowerShell scopes once, but should only need Application Admin to consent to API permissions and Exchange Admin to create Exchange role groups/assign permissions

# 1) Install Graph PowerShell and ExchangeOnlineManagement modules

Install-Module Microsoft.Graph -Scope CurrentUser
Install-Module ExchangeOnlineManagement -Scope CurrentUser

# 2) Connect to Graph, consent so we can assign API permissions to the Managed Identity, and get IDs for Managed Identity

Connect-MgGraph -Scopes AppRoleAssignment.ReadWrite.All,Application.Read.All

$MI_ID = <Copy Managed Identity Object ID from Azure Automation>
$AppId = (Get-MgServicePrincipal -ServicePrincipalId $MI_ID).AppId

# 3) Grant Managed Identity permissions to talk to Exchange

$ResourceID = (Get-MgServicePrincipal -Filter "AppId eq '00000002-0000-0ff1-ce00-000000000000'").Id
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $MI_ID -PrincipalId $MI_ID -AppRoleId "dc50a0fb-09a3-484d-be87-e023b12c6440" -ResourceId $ResourceID

# 4) Create a linked Exchange Service Principal and grant it least permissions to run the necessary commands

Connect-ExchangeOnline

# Create linked Service Principal ($AppId and $MI_ID from earlier)
New-ServicePrincipal -AppId $AppId -ObjectId $MI_ID -DisplayName "exo-automation"

# Create new Management role
New-ManagementRole -Name "Mailbox Auditing" -Parent "Audit Logs" -Verbose

# Remove unnecessary permissions
Get-ManagementRoleEntry "Mailbox Auditing\*" | Where-Object { $_.Name -notin "Get-Mailbox" } | ForEach-Object { Remove-ManagementRoleEntry -Identity "Mailbox Auditing\$($_.Name)" -Verbose -Confirm:$false }

# Add limited Set-Mailbox permissions
Add-ManagementRoleEntry -Identity "Mailbox Auditing\Set-Mailbox" -Parameters "Identity","AuditAdmin","AuditDelegate","AuditOwner","AuditEnabled","AuditLogAgeLimit"

# Create a Role Group, add our custom Mailbox Auditing role, and add our Service Principal as a member
New-RoleGroup "Advanced Auditing Management" -Description "Limited scope for Azure Automation to set Advanced Auditing entries" -Roles "Mailbox Auditing" -Members $MI_ID -Confirm:$false -Verbose

# 5) Take a nice long break, permissions will take a while to replicate ;)

#>
