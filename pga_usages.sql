select
    pid,
    program,
    sum(pga_used_mem),
    sum(pga_alloc_mem),
    sum(pga_freeable_mem),
    sum(pga_max_mem)
from gv$process
group by pid,program
order by 3 desc
;
