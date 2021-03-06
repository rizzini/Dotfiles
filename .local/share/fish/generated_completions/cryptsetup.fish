# cryptsetup
# Autogenerated from man page /usr/share/man/man8/cryptsetup.8.gz
complete -c cryptsetup -l verbose -s v -d 'Print more information on command execution'
complete -c cryptsetup -l debug -l debug-json -d 'Run in debug mode with full diagnostic logs'
complete -c cryptsetup -l type -d 'Specifies required device type, for more info read BASIC ACTIONS section'
complete -c cryptsetup -l hash -s h -d 'Specifies the passphrase hash for open (for plain and loopaes device types)'
complete -c cryptsetup -l cipher -s c -d 'Set the cipher specification string'
complete -c cryptsetup -l verify-passphrase -s y -d 'When interactively asking for a passphrase, ask for it twice and complain if …'
complete -c cryptsetup -l key-file -s d -d 'Read the passphrase from file'
complete -c cryptsetup -l keyfile-offset -d 'Skip value bytes at the beginning of the key file'
complete -c cryptsetup -l keyfile-size -s l -d 'Read a maximum of value bytes from the key file'
complete -c cryptsetup -l new-keyfile-offset -d 'Skip value bytes at the start when adding a new passphrase from key file with…'
complete -c cryptsetup -l new-keyfile-size -d 'Read a maximum of value bytes when adding a new passphrase from key file with…'
complete -c cryptsetup -l master-key-file -d 'Use a master key stored in a file'
complete -c cryptsetup -l dump-master-key -d 'For luksDump this option includes the master key in the displayed information'
complete -c cryptsetup -l json-file -d 'Read token json from a file or write token to it'
complete -c cryptsetup -l use-urandom -d 'For luksFormat these options define which kernel random number generator will…'
complete -c cryptsetup -l key-slot -s S -d 'For LUKS operations that add key material, this options allows you to specify…'
complete -c cryptsetup -l key-size -s s -d 'Sets key size in bits.  The argument has to be a multiple of 8'
complete -c cryptsetup -l size -s b -d 'Set the size of the device in sectors of 512 bytes'
complete -c cryptsetup -l offset -s o -d 'Start offset in the backend device in 512-byte sectors'
complete -c cryptsetup -l skip -s p -d 'Start offset used in IV calculation in 512-byte sectors (how many sectors of …'
complete -c cryptsetup -l device-size -d 'Instead of real device size, use specified value'
complete -c cryptsetup -l readonly -s r -d 'set up a read-only mapping'
complete -c cryptsetup -l shared -d 'Creates an additional mapping for one common ciphertext device'
complete -c cryptsetup -l pbkdf -d 'Set Password-Based Key Derivation Function (PBKDF) algorithm for LUKS keyslot'
complete -c cryptsetup -l iter-time -s i -d 'The number of milliseconds to spend with PBKDF passphrase processing'
complete -c cryptsetup -l pbkdf-memory -d 'Set the memory cost for PBKDF (for Argon2i/id the number represents kilobytes)'
complete -c cryptsetup -l pbkdf-parallel -d 'Set the parallel cost for PBKDF (number of threads, up to 4)'
complete -c cryptsetup -l pbkdf-force-iterations -d 'Avoid PBKDF benchmark and set time cost (iterations) directly'
complete -c cryptsetup -l batch-mode -s q -d 'Suppresses all confirmation questions'
complete -c cryptsetup -l progress-frequency -d 'Print separate line every <seconds> with wipe progress'
complete -c cryptsetup -l timeout -s t -d 'The number of seconds to wait before timeout on passphrase input via terminal'
complete -c cryptsetup -l tries -s T -d 'How often the input of the passphrase shall be retried'
complete -c cryptsetup -l align-payload -d 'Align payload at a boundary of value 512-byte sectors'
complete -c cryptsetup -l uuid -d 'Use the provided UUID for the luksFormat command instead of generating a new …'
complete -c cryptsetup -l allow-discards -d 'Allow the use of discard (TRIM) requests for the device'
complete -c cryptsetup -l perf-same_cpu_crypt -d 'Perform encryption using the same cpu that IO was submitted on'
complete -c cryptsetup -l perf-submit_from_crypt_cpus -d 'Disable offloading writes to a separate thread after encryption'
complete -c cryptsetup -l perf-no_read_workqueue -l perf-no_write_workqueue -d 'Bypass dm-crypt internal workqueue and process read or write requests synchro…'
complete -c cryptsetup -l test-passphrase -d 'Do not activate the device, just verify passphrase'
complete -c cryptsetup -l header -d 'Use a detached (separated) metadata device or file where the LUKS header is s…'
complete -c cryptsetup -l header-backup-file -d 'Specify file with header backup for luksHeaderBackup or luksHeaderRestore act…'
complete -c cryptsetup -l force-password -d 'Do not use password quality checking for new LUKS passwords'
complete -c cryptsetup -l deferred -d 'Defers device removal in close command until the last user closes it'
complete -c cryptsetup -l disable-locks -d 'Disable lock protection for metadata on disk'
complete -c cryptsetup -l disable-keyring -d 'Do not load volume key in kernel keyring and store it directly in the dm-cryp…'
complete -c cryptsetup -l key-description -d 'Set key description in keyring for use with token command'
complete -c cryptsetup -l priority -d 'Set a priority for LUKS2 keyslot'
complete -c cryptsetup -l token-id -d 'Specify what token to use in actions token, open or resize'
complete -c cryptsetup -l token-only -d 'Do not proceed further with action (any of token, open or resize) if token ac…'
complete -c cryptsetup -l sector-size -d 'Set sector size for use with disk encryption'
complete -c cryptsetup -l iv-large-sectors -d 'Count Initialization Vector (IV) in larger sector size (if set) instead of 51…'
complete -c cryptsetup -l persistent -d 'If used with LUKS2 devices and activation commands like open or refresh, the …'
complete -c cryptsetup -l refresh -d 'Refreshes an active device with new set of parameters'
complete -c cryptsetup -l label -d '"--subsystem <SUBSYSTEM>" Set label and subsystem description for LUKS2 devic…'
complete -c cryptsetup -l integrity -d 'Specify integrity algorithm to be used for authenticated disk encryption in L…'
complete -c cryptsetup -l luks2-metadata-size -d 'This option can be used to enlarge the LUKS2 metadata (JSON) area'
complete -c cryptsetup -l luks2-keyslots-size -d 'This option can be used to set specific size of the LUKS2 binary keyslot area…'
complete -c cryptsetup -l keyslot-cipher -d 'This option can be used to set specific cipher encryption for the LUKS2 keysl…'
complete -c cryptsetup -l keyslot-key-size -d 'This option can be used to set specific key size for the LUKS2 keyslot area'
complete -c cryptsetup -l integrity-no-journal -d 'Activate device with integrity protection without using data journal (direct …'
complete -c cryptsetup -l integrity-no-wipe -d 'Skip wiping of device authentication (integrity) tags'
complete -c cryptsetup -l unbound -d 'Creates new or dumps existing LUKS2 unbound keyslot'
complete -c cryptsetup -l tcrypt-hidden -d '"--tcrypt-system"  "--tcrypt-backup" Specify which TrueCrypt on-disk header w…'
complete -c cryptsetup -l veracrypt -d 'Allow VeraCrypt compatible mode.  Only for TCRYPT extension'
complete -c cryptsetup -l veracrypt-pim -d '"--veracrypt-query-pim" Use a custom Personal Iteration Multiplier (PIM) for …'
complete -c cryptsetup -l serialize-memory-hard-pbkdf -d 'Use a global lock to serialize unlocking of keyslots using memory-hard PBKDF'
complete -c cryptsetup -l encrypt -d 'Initialize (and run) device encryption (reencrypt action parameter)'
complete -c cryptsetup -l decrypt -d 'Initialize (and run) device decryption (reencrypt action parameter)'
complete -c cryptsetup -l init-only -d 'Initialize reencryption (any variant) operation in LUKS2 metadata only and ex…'
complete -c cryptsetup -l resume-only -d 'Resume reencryption (any variant) operation already described in LUKS2 metada…'
complete -c cryptsetup -l resilience -d 'Reencryption resilience mode can be one of checksum, journal or none'
complete -c cryptsetup -l resilience-hash -d 'The hash algorithm used with "--resilience checksum" only'
complete -c cryptsetup -l hotzone-size -d 'This option can be used to set an upper limit on the size of reencryption are…'
complete -c cryptsetup -l reduce-device-size -d 'Initialize LUKS2 reencryption with data device size reduction (currently only…'
complete -c cryptsetup -l version -d 'Show the program version'
complete -c cryptsetup -l usage -d 'Show short option help'
complete -c cryptsetup -l use-random
complete -c cryptsetup -l subsystem
complete -c cryptsetup -l tcrypt-system -l tcrypt-backup
complete -c cryptsetup -l veracrypt-query-pim
complete -c cryptsetup -l help -s '?' -d 'Show help text and default parameters.  EXAMPLE'

