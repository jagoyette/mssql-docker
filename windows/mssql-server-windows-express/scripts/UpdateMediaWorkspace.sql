GO
PRINT N'Modifying [dbo].[MediaWorkspace]...';
/*
       When a Galaxis/Sicat dependent workspace is persisted, it shall be 
       restored as a 'normal' Sidexis lightdesk.
*/
UPDATE [dbo].[MediaWorkspace] 
SET    [WorkspaceType] = N'Lightdesk'
WHERE  [WorkspaceType] LIKE N'LightdeskDependent_Galaxis'
   OR  [WorkspaceType] LIKE N'LightdeskDependent_SICATSuite';

GO
PRINT N'Modifying [dbo].[MediaWorkspace] done!';
GO
