function yt
    if [ -n "$argv[1]" ]
        cd /home/lucas/Downloads;
        yt-dlp "$argv[1]" &> /dev/null & disown $last_pid;
    else
        echo "nada a ser feito. saindo.."
    end
end
