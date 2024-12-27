pgrep chrome | while read pid; do
    args=$(cat /proc/$pid/cmdline | sed -e "s/\x00/ /g")
    name=$(echo $args | cut -c1-25)
    if echo $name | grep -E "\/opt\/google\/chrome\/chrome|google-chrome"; then
        parsed=$(echo $args | sed "s/--login-(user|profile|manager)[^ ]+/ /")
        pkill -9 chrome
        $parsed --login-manager --allow-failed-policy-fetch-for-test
        break
    fi
done
