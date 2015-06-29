UPDATE main.Tasks 
SET containerId = :backLogId 
WHERE containerId = :oldContainer