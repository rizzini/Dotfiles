# stress
# Autogenerated from man page /usr/share/man/man1/stress.1.gz
complete -c stress -s '?' -l help -d 'show this help statement'
complete -c stress -l version -d 'show version statement'
complete -c stress -s v -l verbose -d 'be verbose'
complete -c stress -s q -l quiet -d 'be quiet'
complete -c stress -s n -l dry-run -d 'show what would have been done'
complete -c stress -s t -l timeout -d 'timeout after N seconds'
complete -c stress -l backoff -d 'wait factor of N microseconds before work starts'
complete -c stress -s c -l cpu -d 'spawn N workers spinning on sqrt()'
complete -c stress -s i -l io -d 'spawn N workers spinning on sync()'
complete -c stress -s m -l vm -d 'spawn N workers spinning on malloc()/free()'
complete -c stress -l vm-bytes -d 'malloc B bytes per vm worker (default is 256MB)'
complete -c stress -l vm-stride -d 'touch a byte every B bytes (default is 4096)'
complete -c stress -l vm-hang -d 'sleep N secs before free (default none, 0 is inf)'
complete -c stress -l vm-keep -d 'redirty memory instead of freeing and reallocating'
complete -c stress -s d -l hdd -d 'spawn N workers spinning on write()/unlink()'
complete -c stress -l hdd-bytes -d 'write B bytes per hdd worker (default is 1GB)'

