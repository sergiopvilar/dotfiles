alias tower='gittower ./'

# Other Alias
alias run='cd ~/rel/rpm && script/develop'
alias setup='cd ~/rel/rpm && SSHUSER=sergio script/setup'
alias kill_idle="ps aux | grep postgres | grep idle | awk '{print $2}' | xargs kill"
alias su_setup='cd ~/rel/rpm && SSHUSER=sergio script/setup --ssh-user=sergio --superuser=sergio'
alias batutinhas='ssh sergio@192.168.27.120'