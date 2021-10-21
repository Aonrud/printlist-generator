#!/bin/bash

FNTEXT=0

while getopts "t" arg; do
	case "${arg}" in
		t) FNTEXT=1
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
			echo "${FILE%.*}" >> temp.tex
		fi
	fi

	echo '\clearpage' >> temp.tex
done

echo '\end{document}' >> temp.tex


pdflatex -interaction=batchmode temp.tex

rm temp.tex temp.log temp.aux
