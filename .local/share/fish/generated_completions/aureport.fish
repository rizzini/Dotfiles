# aureport
# Autogenerated from man page /usr/share/man/man8/aureport.8.gz
complete -c aureport -o au -l auth -d 'Report about authentication attempts'
complete -c aureport -s a -l avc -d 'Report about avc messages'
complete -c aureport -l comm -d 'Report about commands run'
complete -c aureport -s c -l config -d 'Report about config changes'
complete -c aureport -o cr -l crypto -d 'Report about crypto events'
complete -c aureport -l eoe-timeout -d 'Set the end of event parsing timeout.  See end_of_event_timeout in auditd'
complete -c aureport -s e -l event -d 'Report about events'
complete -c aureport -l escape -d 'This option determines if the output is escaped to make the content safer for…'
complete -c aureport -s f -l file -d 'Report about files and af_unix sockets'
complete -c aureport -l failed -d 'Only select failed events for processing in the reports'
complete -c aureport -s h -l host -d 'Report about hosts'
complete -c aureport -l help -d 'Print brief command summary'
complete -c aureport -s i -l interpret -d 'Interpret  numeric  entities into text'
complete -c aureport -o if -l input -d 'Use the given file or directory instead of the logs'
complete -c aureport -l input-logs -d 'Use the log file location from auditd. conf as input for analysis'
complete -c aureport -l integrity -d 'Report about integrity events'
complete -c aureport -s k -l key -d 'Report about audit rule keys'
complete -c aureport -s l -l login -d 'Report about logins'
complete -c aureport -s m -l mods -d 'Report about account modifications'
complete -c aureport -o ma -l mac -d 'Report about Mandatory Access Control (MAC) events'
complete -c aureport -s n -l anomaly -d 'Report about anomaly events'
complete -c aureport -l node -d 'Only select events originating from node name string for processing in the re…'
complete -c aureport -o nc -l no-config -d 'Do not include the CONFIG_CHANGE event'
complete -c aureport -s p -l pid -d 'Report about processes'
complete -c aureport -s r -l response -d 'Report about responses to anomaly events'
complete -c aureport -s s -l syscall -d 'Report about syscalls'
complete -c aureport -l success -d 'Only select successful events for processing in the reports'
complete -c aureport -l summary -d 'Run the summary report that gives a total of the elements of the main report'
complete -c aureport -s t -l log -d 'This option will output a report of the start and end times for each log'
complete -c aureport -l tty -d 'Report about tty keystrokes'
complete -c aureport -o te -l end -d 'Search for events with time stamps equal to or before the given end time'
complete -c aureport -o tm -l terminal -d 'Report about terminals'
complete -c aureport -o ts -l start -d 'Search for events with time stamps equal to or after the given end time'
complete -c aureport -s u -l user -d 'Report about users'
complete -c aureport -s v -l version -d 'Print the version and exit'
complete -c aureport -l virt -d 'Report about Virtualization events'
complete -c aureport -s x -l executable -d 'Report about executables'

