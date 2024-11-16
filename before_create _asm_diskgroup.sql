set lines 999;
col diskgroup for a15
col diskname for a15
col path for a35
select a.name DiskGroup,b.name DiskName, b.total_mb, (b.total_mb-b.free_mb) Used_MB, b.free_mb,b.path,b.header_status
from v$asm_disk b, v$asm_diskgroup a
where a.group_number (+) =b.group_number
order by b.group_number,b.name;
