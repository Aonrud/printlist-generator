#!/bin/bash

FNTEXT=0
NUMBERED=0

while getopts "tn" arg; do
	case "${arg}" in
		t) FNTEXT=1
			;;
		n) NUMBERED=1
			;;
		?) echo "Invalid option"; exit 1
	esac
done

echo '\documentclass{article}
\usepackage[margin=0.5in]{geometry}
\usepackage{graphicx}
\usepackage[labelformat=empty]{caption}
\usepackage{enumitem}

\begin{document}' > temp.tex

for FILE in *.jpg; do
	echo "\begin{figure}
		\includegraphics[width=\textwidth,height=\textheight,keepaspectratio]{${FILE}}
		\end{figure}" >> temp.tex

	TEXT="${FILE%.*}.txt"
	if [ -f "${TEXT}" ]
	then
		sed -z 's/\n/\n\n\\medskip\n\n/g' ${TEXT} >> temp.tex
	else
		if [ "${FNTEXT}" -eq 1 ]
		then
			TEXT="${FILE%.*}"
			if [ "${NUMBERED}" -eq 1 ]
			then
				TEXT=$(echo "${TEXT}" | sed -n 's/^[[:digit:]]\+_\(.*\)$/\1/p')
			fi
			echo "${TEXT}" >> temp.tex
		fi
	fi

	echo '\clearpage' >> temp.tex
done

echo '\end{document}' >> temp.tex


pdflatex -interaction=batchmode temp.tex

rm temp.tex temp.log temp.aux
