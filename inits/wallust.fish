#!/bin/fish

set AWWW_DIR (ls -d $HOME/.cache/awww/*/  | head -1)
set LINK_DIR "$HOME/.cache/awww"

function update_symlinks
    for cache_file in $AWWW_DIR/*
        set monitor (basename $cache_file)
        set wallpaper (tr -d '\000' < $cache_file | rg -o '/home/[^[:space:]]*\.\(jpg\|jpeg\|png\|webp\)$')
        if test -n "$wallpaper"
            ln -sf $wallpaper $LINK_DIR/current-$monitor
        end
    end
end

update_symlinks
set last_state (cat $AWWW_DIR/*)

while true
    set current_state (cat $AWWW_DIR/*)

    if test "$current_state" != "$last_state"
        set last_state $current_state
        update_symlinks

        for cache_file in $AWWW_DIR/*
            set wallpaper (tr -d '\000' < $cache_file | rg -o '/home/[^[:space:]]*\.\(jpg\|jpeg\|png\|webp\)$')
            if test -n "$wallpaper"
                wallust run -s $wallpaper
                break
            end
        end

        # pkill -SIGUSR2 waybar
    end

    sleep 2
end
