function fish_prompt
    echo $history[1] | grep -Ev '(^hh$|^sd|^l.$)' >> ~/.config/fish/hh.history
end
