AUTOSAVE=/root/synApps_5_8/support/autosave-5-6-1 

# BEGIN save_restore.cmd ------------------------------------------------------

### save_restore setup

# status PVs
#save_restoreSet_UseStatusPVs(1)
save_restoreSet_status_prefix("det1:")
dbLoadRecords("$(AUTOSAVE)/asApp/Db/save_restoreStatus.db", "P=xxx:, DEAD_SECONDS=5")

# Ok to save/restore save sets with missing values (no CA connection to PV)?
save_restoreSet_IncompleteSetsOk(1)

# Save dated backup files?
save_restoreSet_DatedBackupFiles(1)

# Number of sequenced backup files to write
save_restoreSet_NumSeqFiles(3)

# Time interval between sequenced backups
save_restoreSet_SeqPeriodInSeconds(300)

# Ok to retry connecting to PVs whose initial connection attempt failed?
save_restoreSet_CAReconnect(1)

# Time interval in seconds between forced save-file writes.  (-1 means forever).
# This is intended to get save files written even if the normal trigger mechanism is broken.
save_restoreSet_CallbackTimeout(-1)

# specify where save files should be
set_savefile_path("$(TOP)/iocBoot/$(IOC)", "autosave")

###
# specify what save files should be restored.  Note these files must be
# in the directory specified in set_savefile_path(), or, if that function
# has not been called, from the directory current when iocInit is invoked

#set_pass0_restoreFile("auto_positions.sav", "P=xxx:")
# Save positions every five seconds
#doAfterIocInit("create_monitor_set('auto_positions.req',5,'P=xxx:')")

set_pass0_restoreFile("hera_settings.sav")
set_pass1_restoreFile("hera_array_settings.sav")
# save settings every thirty seconds
doAfterIocInit("create_monitor_set('auto_settings.req',30)")

# Note that you can reload these sets after creating them: e.g., 
# reload_monitor_set("auto_settings.req",30,"P=xxx:")

# Note that you can restore a .sav file without also autosaving to it.
#set_pass0_restoreFile("myInitData.sav")
#set_pass1_restoreFile("myInitData.sav")

# Also, you can restore a .sav file that contains macros. (autosave R5-4-2)
#set_pass0_restoreFile("myGenericData.sav", "P=xxx:")
#set_pass1_restoreFile("myGenericData.sav", "P=xxx:")

###
# specify directories in which to to search for included request files
set_requestfile_path("$(TOP)/iocBoot/$(IOC)", "")
set_requestfile_path("$(TOP)/iocBoot/$(IOC)", "autosave")
set_requestfile_path("$(AUTOSAVE)", "asApp/Db")

# Debug-output level
save_restoreSet_Debug(0)

# Tell autosave to automatically build built_settings.req and
# built_positions.req from databases and macros supplied to dbLoadRecords()
# (and dbLoadTemplate(), which calls dbLoadRecords()).
#epicsEnvSet("BUILT_SETTINGS", "built_settings.req")
#epicsEnvSet("BUILT_POSITIONS", "built_positions.req")
#autosaveBuild("$(BUILT_SETTINGS)", "_settings.req", 1)
#autosaveBuild("$(BUILT_POSITIONS)", "_positions.req", 1)

# END save_restore.cmd --------------------------------------------------------
